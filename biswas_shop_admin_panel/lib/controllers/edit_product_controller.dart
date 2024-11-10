
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
        .where('productId', isEqualTo: productModel.productId) // Filter if necessary
        .snapshots()
        .listen(
          (QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          for (var doc in snapshot.docs) {
            final data = doc.data() as Map<String, dynamic>?;
            // print("Document data: $data");

            if (data != null && data['productImages'] is List) {
              images.value = List<String>.from(data['productImages'] as List);
              // print("Fetched product images: ${images.value}");
              update();
            } else {
              print("Error: 'productImages' is not a list or is null.");
            }
          }
        } else {
          print("Error: No documents found.");
        }
      },
      onError: (error) {
        print("Error fetching data from Firestore: $error");
      },
    );

  }
}