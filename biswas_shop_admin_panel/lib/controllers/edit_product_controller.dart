
import 'package:biswas_shop_admin_panel/model/product-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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


  //delete images
  Future deleteImagesFromStorage(String imageUrl) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    try {
      Reference reference = storage.refFromURL(imageUrl);
      await reference.delete();
    } catch (e) {
      print("Error $e");
    }
  }

  //collection
  Future<void> deleteImageFromFireStore(
      String imageUrl, String productId) async {
    try {
      // await FirebaseFirestore.instance
      //     .collection('product')
      //     .doc(productId)
      //     .update({
      //   'productImages': FieldValue.arrayRemove([imageUrl])
      // });

      var querySnapshot = await FirebaseFirestore.instance
          .collection('product')
          .where('productId', isEqualTo: productId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Access the first document found
        var docRef = querySnapshot.docs.first.reference;
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Check if 'productImages' contains the specific imageUrl
        if (data['productImages'] != null && (data['productImages'] as List).contains(imageUrl)) {

          // Remove imageUrl from 'productImages' array
          await docRef.update({
            'productImages': FieldValue.arrayRemove([imageUrl])
          });

        } else {
          print("Image URL not found in 'productImages' array.");
        }
      } else {
        print("Error: No document found with the specified productId.");
      }

      update();
    } catch (e) {
      print("Error : $e");
    }
  }
}