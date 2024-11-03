
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
        title: Text("Confirmed orders"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productTotalPrice.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('x' + orderModel.productQuantity.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productDescription),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                foregroundImage: NetworkImage(orderModel.productImages[0]),
              ),
              CircleAvatar(
                radius: 50.0,
                foregroundImage: NetworkImage(orderModel.productImages[1]),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerPhone),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerAddress),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerId),
          ),
        ],
      ),
    );
  }
}
