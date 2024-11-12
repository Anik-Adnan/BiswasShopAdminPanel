

import 'package:biswas_shop_admin_panel/controllers/category_dropdown_controller.dart';
import 'package:biswas_shop_admin_panel/controllers/count_all_products_controller.dart';
import 'package:biswas_shop_admin_panel/model/product-model.dart';
import 'package:biswas_shop_admin_panel/screens/add_product_screen.dart';
import 'package:biswas_shop_admin_panel/screens/edit_product_screen.dart';
import 'package:biswas_shop_admin_panel/screens/single_product_screen.dart';
import 'package:biswas_shop_admin_panel/utils/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key,});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final CountAllproductsController _getProductsCount =
  Get.put(CountAllproductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
              'All Products (${_getProductsCount.productsCount.toString()})');
        }),
        backgroundColor: AppConstant.appMainColor,
        actions: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: (){Get.to(()=> AddProductScreen());},
              child: Text("Add",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),),),
          ),
        ],
      ),

      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('product')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error occurred while fetching products!'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No products found!'),
              ),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];

                ProductModel productModel = ProductModel(
                    productId: data['productId'],
                    categoryId: data['categoryId'],
                    productName: data['productName'],
                    categoryName: data['categoryName'],
                    salePrice: data['salePrice'],
                    fullPrice: data['fullPrice'],
                    productImages: data['productImages'],
                    deliveryTime: data['deliveryTime'],
                    isSale: data['isSale'],
                    productDescription: data['productDescription'],
                    createdAt: data['createdAt'],
                    updatedAt: data['updatedAt'],
                );


                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () => Get.to(
                          () => SingleProductScreen(
                            docId: data.id,
                            productModel: productModel,
                          ),
                    ),

                    leading: data['productImages'] != null  ?
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        productModel.productImages[0],
                        errorListener: (err) {
                          // Handle the error here
                          print('Error loading image');
                          Icon(Icons.error);
                        },
                      ),
                    ) : 
                    CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      child: Text(data['productName'][0],style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    title: Text(data['productName']),
                    subtitle: Text("Sale Price: "+data['salePrice']+" tk"),
                    trailing: GestureDetector(
                      onTap: (){

                        final editProductCategoryController = Get.put(CategoryDropDownController());
                        editProductCategoryController.setPreviousCategory(productModel.categoryId);

                        Get.to(()=> EditProductScreen(productModel: productModel));
                      },
                      child: Icon(Icons.edit,
                      size: 30.0,color: Colors.black,),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}