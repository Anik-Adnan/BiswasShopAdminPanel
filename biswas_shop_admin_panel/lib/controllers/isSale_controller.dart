
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class IsSaleController extends GetxController{
  RxBool isSale = false.obs;

  void toogleIsSale(bool value){
    isSale.value = value;
    update();
  }
  void setIsSaleOldVale(bool value){
    isSale.value = value;
    update();
  }
}