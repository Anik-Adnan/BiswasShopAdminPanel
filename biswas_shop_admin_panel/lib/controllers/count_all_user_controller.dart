
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CountAllUserController extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late StreamSubscription<QuerySnapshot<Map<String,dynamic>>> _userControllerStreamSubscription;

  final Rx<int> userCount = Rx<int>(0);

  @override
  void onInit() {
    super.onInit();
    _userControllerStreamSubscription = _firestore.collection('users').where('isAdmin',isEqualTo: false).snapshots().listen(
        (snapshot){
          userCount.value = snapshot.size;
        }
    );
  }
  @override
  void onClose() {
    _userControllerStreamSubscription.cancel();
    super.onClose();
  }

}