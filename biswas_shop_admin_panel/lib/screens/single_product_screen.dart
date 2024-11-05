
import 'package:biswas_shop_admin_panel/model/order-model.dart';
import 'package:biswas_shop_admin_panel/model/product-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleProductScreen extends StatelessWidget{
  ProductModel productModel;
  String docId;
  SingleProductScreen({super.key, required this.docId,required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product Name : "+productModel.productName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product ID: "+productModel.productId),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product CategoryName : "+productModel.categoryName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product CategoryID : "+productModel.categoryId),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Full Price : "+productModel.fullPrice.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Sale Price : ' + productModel.salePrice.toString()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // show images
              showImages(productModel),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Customer Address : "+productModel.productDescription),
          ),
        ],
      ),
    );
  }

  Widget showImages(ProductModel productModel){
    var images = productModel.productImages;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images.map((image){
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50.0,
              foregroundImage: NetworkImage(image),
            ),
          );
        }).toList(),
      ),
    );
  }
}
