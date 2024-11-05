
import 'package:biswas_shop_admin_panel/model/order-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckSingleOrderScreen extends StatelessWidget{
  OrderModel orderModel;
  String docId;
  CheckSingleOrderScreen({super.key, required this.docId,required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirme orders"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product Name : "+orderModel.productName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product Price : "+orderModel.productTotalPrice.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Product quantity : x' + orderModel.productQuantity.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productDescription),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // show images
              showImages(orderModel),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Customer Name: "+orderModel.customerName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Customer Phone : "+orderModel.customerPhone),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Customer Address : "+orderModel.customerAddress),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Customer ID :"+orderModel.customerId),
          ),
        ],
      ),
    );
  }

  Widget showImages(OrderModel orderModel){
    var images = orderModel.productImages;

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
