
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDropDownController extends GetxController{
  RxList<Map<String,dynamic>> categories = <Map<String,dynamic>>[].obs;
  RxString? selectedCategoryId;
  RxString? selectedCategoryName;
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('categoris').get();

      List<Map<String, dynamic>> categoriesList = [];

      for (int i = 0; i < querySnapshot.docs.length; i++) {
        DocumentSnapshot<Map<String, dynamic>> document = querySnapshot.docs[i];
        categoriesList.add({
          'categoryId': document['categoryId'],
          'categoryName': document['categoryName'],
          'categoryImg': document['categoryImg'],
        });
      };

      // querySnapshot.docs
      //     .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
      //   categoriesList.add({
      //     'categoryId': document['categoryId'],
      //     'categoryName': document['categoryName'],
      //     'categoryImg': document['categoryImg'],
      //   });
      //   print("category ID"+document['categoryId']);
      // });

      categories.value = categoriesList;
      // print(categories);
      update();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }


  // Method to fetch category name based on category ID
  Future<String?> getCategoryName(String? categoryId) async {
    try {
      // Access Firestore collection and document
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('categoris')
          .doc(categoryId)
          .get();

      // Extract category name from snapshot
      if (snapshot.exists) {
        return snapshot.data()?['categoryName'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching category name: $e");
      return null;
    }
  }


//set selected category
  void setSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    // print('selectedCategoryId $selectedCategoryId');
    update();
  }

  // set categoryName
  void setSelectedCategoryName(String? categoryName) {
    selectedCategoryName = categoryName?.obs;
    // print('selectedCategoryName $selectedCategoryName');
    update();
  }

  // set PreviousCategory
  void setPreviousCategory(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    // print('selectedCategoryId $selectedCategoryId');
    update();
  }


}