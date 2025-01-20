import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  // Map to associate categories with their respective news types
  final RxMap<String, List<String>> categoryToNewsType = <String, List<String>>{
    "Events": [],
    "Institutes": [
      "City",
      'contiene',
      "State",
      "Nation",
      "World",
      "Recent",
      "Popular",
      "Events",
      "Institutions",
    ],
    "News": [
      "City",
      'contiene',
      "State",
      "Nation",
      "World",
      "Recent",
      "Popular",
      "Events",
      "Institutions",
    ],
  }.obs;

  final RxString selectedCategory = "Events".obs; // Default selected category
  final RxString selectedNews = "".obs; // Default selected news type

  List<String> get currentNewsTypeOptions =>
      categoryToNewsType[selectedCategory.value] ??
      []; // Get news types for the selected category

  void updateSelectedCategory(String value) {
    selectedCategory.value = value;
    selectedNews.value = ""; // Reset selected news type when category changes
  }

  void updateSelectedNews(String value) {
    selectedNews.value = value;
  }
}
