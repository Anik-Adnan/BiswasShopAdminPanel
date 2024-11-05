
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CountAllproductsController extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late StreamSubscription<QuerySnapshot<Map<String,dynamic>>> _userControllerStreamSubscription;

  final Rx<int> productsCount = Rx<int>(0);

  @override
  void onInit() {
    super.onInit();
    _userControllerStreamSubscription = _firestore.collection('product').snapshots().listen(
            (snapshot){
          productsCount.value = snapshot.size;
        }
    );
  }
  @override
  void onClose() {
    _userControllerStreamSubscription.cancel();
    super.onClose();
  }

}