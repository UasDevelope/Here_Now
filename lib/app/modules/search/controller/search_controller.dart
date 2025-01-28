import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:here_now/app/controllers/controller_locator.dart';
import 'package:here_now/app/controllers/location.dart';
import '../../home/model/news_model.dart';

class SearchScreenController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  RxBool isNews = false.obs;

  var newsList = <NewsWithScore>[].obs;
  var filteredNewsList = <NewsWithScore>[].obs;

  RxString searchedValue = "".obs;

  final homeController = ControllerLocator.homeController;
  final eventController = ControllerLocator.eventsController;
  // Assign values and filter the news based on the value of `isNews`

  // Change between News and Events
  void changeNewsToEvent(bool newValue) {
    isNews.value = newValue;
  }

  // Update the search input value
  void changeSearchValue(String newValue, bool isNews) {
    searchedValue.value = newValue;

    if (isNews) {
      homeController.applyNewsFilter();
    } else {
      eventController.applyEventFilter();
    }
  }

  // Apply filter based on the search input and news type
  void applyNewsFilter() {
    if (searchedValue.value.isEmpty) {
      // If search input is empty, show all news
      filteredNewsList.value = newsList;
    } else {
      // Filter the list based on search input
      filteredNewsList.value = newsList
          .where((news) =>
              news.title
                  .toLowerCase()
                  .contains(searchedValue.value.toLowerCase()) ||
              news.description
                  .toLowerCase()
                  .contains(searchedValue.value.toLowerCase()))
          .toList();
    }
  }
}
