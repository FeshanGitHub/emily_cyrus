import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  final appbaseurl;

  ApiClient({this.appbaseurl}){
    baseUrl = appbaseurl;

  }

  Future<Response> getData (String uri) async {
    Response response = await get(uri);
    return response;
  }



}