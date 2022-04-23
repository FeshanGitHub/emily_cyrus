import 'package:get/get.dart';
import '../Api/api.dart';

class EmilyRepo extends GetxService{
  final ApiClient apiClient;
  EmilyRepo({required this.apiClient});

  Future<Response> getItemList() async {
    return await apiClient.getData('http://cgprojects.in/flutter/');
  }

}