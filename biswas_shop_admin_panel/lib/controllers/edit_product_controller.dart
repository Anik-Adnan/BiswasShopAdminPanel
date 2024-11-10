
import 'package:biswas_shop_admin_panel/model/product-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController{
  ProductModel productModel;
  EditProductController({required this.productModel});
  RxList<String> images = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRealTimeImages();

  }

  void getRealTimeImages(){
    FirebaseFirestore.instance
        .collection('product')
        .doc().snapshots()
        .listen(
            (DocumentSnapshot snapshot){
              if(snapshot.exists){
                final data = snapshot.data() as Map<String,dynamic>?;
                print("all snapshot data: ${data}");

                if(data != null && data['productImages'] != null){
                  images.value = List<String>.from(data['productImages'] as List<dynamic>);
                  update();
                }
              }else{
                print("error : fetching the images");
              }
            }
    );
  }
}