import 'package:get/get.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import '../../home/model/news_model.dart';

class InstituteController extends GetxController {
  var newsList = <NewsWithScore>[].obs;
  // Future<void> fetchInstitute() async {
  //   try {
  //     final response =
  //         await ApiClient().get(ApiEndPoints.getNews();
  //   } catch (e) {
  //     ShortMessageUtils.showError("$e");
  //   }
  // }
}
