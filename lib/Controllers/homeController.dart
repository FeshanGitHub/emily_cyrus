import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Repository/repository.dart';

class HomeController extends GetxController{
  final EmilyRepo emilyRepo;

  HomeController({required this.emilyRepo});
  List<dynamic> _itemList = [];
  List<dynamic> get itemList => _itemList;

  var _Booking = {};
  Map get Booking => _Booking;



  bool _loading = true ;
  bool get loading => _loading;

  Future getitemList () async {
    Response response = await  emilyRepo.getItemList();

    if(response.statusCode == 200){

      _itemList = [];
      var bodyPackage = jsonDecode(response.body)['packages'];
      var bodyBooking = jsonDecode(response.body)['current_bookings'];


      _Booking = bodyBooking;
      _itemList.addAll(bodyPackage);
      _loading = false;
      update();
    }
  }
}