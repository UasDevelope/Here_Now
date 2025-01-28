import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:here_now/app/controllers/controller_locator.dart';
import 'package:here_now/app/modules/home/model/news_model.dart';
import 'package:here_now/app/modules/loading/widget/custom_loading_widget.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/images.dart';
import 'package:here_now/app/utils/short_message_utils.dart';

import '../model/news_comment_model.dart';

class HomeController extends GetxController {
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  // Reactive markers
  var markers = <Marker>{}.obs;
  // Default camera position centered in Italy

  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(42.8333, 12.8333),
    zoom: 4.5,
  ).obs;
  Future<BitmapDescriptor> _customIcon() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(40, 40)), Images.marker);
  }

  RxList<LatLng> newLocation = <LatLng>[].obs;

  void loadMarkers() async {
    final updatedMarkers = <Marker>{}; // Temporary set to hold markers
    for (int i = 0; i < newLocation.length; i++) {
      updatedMarkers.add(
        Marker(
          markerId: MarkerId("Marker_$i"),
          position: newLocation[i],
          infoWindow: InfoWindow(
            title: "Location ${i + 1}",
            snippet: "News in this area",
          ),
        ),
      );
    }
    markers.value = updatedMarkers; // Update the reactive set
  }

  RxDouble rated = RxDouble(0);
  RxBool isLoading = false.obs;
  RxBool mapLoading = false.obs;

  void changeRating(double rating) {
    rated.value = rating;
  }

  RxString selectedNewsType = "".obs;

  void changeSelectedNewsType(String newValue) {
    if (selectedNewsType.value == newValue) {
      selectedNewsType.value = "";
    } else {
      selectedNewsType.value = newValue;
    }
    fetchNews();
  }

  var newsList = <NewsWithScore>[].obs;

  var filteredNewsList = <NewsWithScore>[].obs;

  void applyNewsFilter() {
    String searchValue = ControllerLocator.searchController.searchedValue.value;
    log("Search value is $searchValue");
    if (searchValue.isEmpty) {
      filteredNewsList.value = newsList;
    } else {
      // Filter the list based on search input
      filteredNewsList.value = newsList
          .where((news) =>
              news.title.toLowerCase().contains(searchValue.toLowerCase()) ||
              news.description
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
          .toList();
    }
  }

  var commentList = <NewsComment>[].obs;
  RxBool commentLoading = false.obs;
  final TextEditingController commentController = TextEditingController();

  Future<void> addComment(String newsId) async {
    var requestedBody = {
      "content": commentController.text,
      "newsId": newsId,
    };
    try {
      CustomLoadingDialog.showCustomLoadingDialog("Adding Comment...");
      final response =
          await ApiClient().post(ApiEndPoints.addNewsComment, requestedBody);
      commentController.clear();
      await fetchComments(newsId);
      CustomLoadingDialog.closeLoadingDialog();
    } catch (e) {
      CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showError("$e");
    }
  }

  Future<void> addRating(String newsId) async {
    var requestedBody = {"newsId": newsId, "ratingValue": rated.value};

    try {
      CustomLoadingDialog.showCustomLoadingDialog(
          "Adding rating to the news...");

      final response =
          await ApiClient().post(ApiEndPoints.addNewsRating, requestedBody);

      log("Response is $response");
      await fetchNews();

      CustomLoadingDialog.closeLoadingDialog();
      Get.back();

      ShortMessageUtils.showSuccess("Rating added successfully");
    } catch (e) {
      CustomLoadingDialog.closeLoadingDialog();

      ShortMessageUtils.showError("$e");
    }
  }

  Future<void> fetchNews({String category = "News"}) async {
    try {
      isLoading.value = true;
      mapLoading.value = true;
      newsList.clear();
      newLocation.clear();
      log("News type is ${selectedNewsType.value}");
      final response = await ApiClient().get(ApiEndPoints.getNews(
          newsType: selectedNewsType.value, category: category));
      log("Response is $response");

      newsList.value = (response["newsWithScores"] as List<dynamic>)
          .map((news) => NewsWithScore.fromJson(news))
          .toList();
      isLoading.value = false;
      applyNewsFilter();
      if (category == "News") {
        final List<NewsWithScore> sortedNewsList = List<NewsWithScore>.from(
            newsList)
          ..sort(
              (a, b) => b.score.compareTo(a.score)); // Sort by score descending

        // Take top 4 scorers
        final top4News = sortedNewsList.take(4);

        // Create a list of LatLng for the top 4
        final List<LatLng> latLngList = top4News
            .map((news) =>
                LatLng(news.lat, news.long)) // Map each news to LatLng
            .toList();
        newLocation.value = latLngList;

        loadMarkers();

        if (latLngList.isNotEmpty) {
          cameraPosition.value = CameraPosition(
            target: latLngList.first,
            zoom: 8.0,
          );
        }
      }
    } catch (e) {
      ShortMessageUtils.showError("$e");
    } finally {
      mapLoading.value = false;
    }
  }

  Future<void> fetchComments(String newsId) async {
    try {
      commentLoading.value = true;
      final response =
          await ApiClient().get(ApiEndPoints.getNewsComments(newsId));
      commentList.value = (response["comments"] as List)
          .map((comment) => NewsComment.fromJson(comment))
          .toList();
      log("Response For comment api is $response");
    } catch (e) {
      log("Error is $e");
    } finally {
      commentLoading.value = false;
    }
  }
}
