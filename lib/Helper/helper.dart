import 'package:emily_cyrus/Controllers/homeController.dart';
import 'package:emily_cyrus/Repository/repository.dart';
import 'package:get/get.dart';
import '../Api/api.dart';


void init(){
  Get.lazyPut(() => ApiClient(appbaseurl: ''));
  Get.lazyPut(() => EmilyRepo(apiClient: Get.find()));
  Get.lazyPut(() => HomeController(emilyRepo: Get.find()));
}