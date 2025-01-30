import 'dart:developer';
import 'package:get/get.dart';
import 'package:here_now/app/modules/events/model/event_model.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:here_now/app/utils/widgets.dart';

import '../model/comment_model.dart';

class EventsController extends GetxController {
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  final TextEditingController commentController = TextEditingController();
  RxList<Event> eventList = <Event>[].obs;
  RxList<Event> filteredEventList = <Event>[].obs;
  RxList<Comment> commentsList = <Comment>[].obs;

  RxBool loading = RxBool(false);
  // CameraPosition, with initial camera position
  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(51.5072, 0.1276), // Initial target LatLng
    zoom: 20.0, // You can set a default zoom value
  ).obs;

  RxDouble rated = RxDouble(0);
  void changeRating(double rating) {
    rated.value = rating;
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllEvents();
  }

  Future<bool> addEventRating(String eventId) async {
    var body = {
      "eventId": eventId,
      "ratingValue": rated.value,
    };
    try {
      CustomLoadingDialog.showCustomLoadingDialog("Adding event  rating....");
      final response =
          await ApiClient().post(ApiEndPoints.addEventRating, body);
      fetchAllEvents();
      log("Response is $response");
      ShortMessageUtils.showSuccess("${response["message"]}");
      return true;
    } catch (e) {
      log("Error$e");
      return false;
    } finally {
      CustomLoadingDialog.closeLoadingDialog();
    }
  }

  Future<bool> addComment(String eventId) async {
    var body = {
      "eventId": eventId,
      "content": commentController.text,
    };
    try {
      // CustomLoadingDialog.showCustomLoadingDialog("Adding event  rating....");
      final response = await ApiClient().post(ApiEndPoints.addComment, body);
      log("Response is $response");
      ShortMessageUtils.showSuccess("${response["message"]}");
      return true;
    } catch (e) {
      log("Error$e");
      return false;
    } finally {
      // CustomLoadingDialog.closeLoadingDialog();
    }
  }

  Future<void> fetchComments(String eventId) async {
    try {
      final response = await ApiClient().get(ApiEndPoints.getComments(eventId));
      log("Response: $response");

      // Parse and assign the response to the model
      if (response != null && response['comments'] != null) {
        commentsList.value = List<Comment>.from(
          response['comments'].map((comment) => Comment.fromJson(comment)),
        );
      }
    } catch (e) {
      log("Error fetching comments: $e");
    }
  }

  void applyEventFilter() {
    String searchValue = ControllerLocator.searchController.searchedValue.value;
    log("Search value is $searchValue");
    if (searchValue.isEmpty) {
      filteredEventList.value = eventList;
    } else {
      // Filter the list based on search input
      filteredEventList.value = eventList
          .where((news) => news.description
              .toLowerCase()
              .contains(searchValue.toLowerCase()))
          .toList();
    }
  }

  Future<void> fetchAllEvents() async {
    loading.value = true;
    try {
      var response = await ApiClient().get(ApiEndPoints.allEvent);
      log("$response");
      if (response["events"] != null) {
        eventList.value = List<Event>.from(
            response["events"].map((events) => Event.fromJson(events)));
        applyEventFilter();
      }
    } catch (e) {
      log("Error$e");
    } finally {
      loading.value = false;
    }
  }
}
