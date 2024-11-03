
import 'package:biswas_shop_admin_panel/model/order-model.dart';
import 'package:biswas_shop_admin_panel/screens/check_single_order_screen.dart';
import 'package:biswas_shop_admin_panel/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecificCustomerOrderScreen extends StatelessWidget{
  String docId;
  String customerName;
  SpecificCustomerOrderScreen({super.key, required this.docId, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Orders'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(docId)
            .collection('confirmOrders')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error occurred while fetching category!'),
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
                child: Text('No orders found!'),
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
                OrderModel orderModel = OrderModel(
                  categoryId: data['categoryId'],
                  categoryName: data['categoryName'],
                  createdAt: data['createdAt'],
                  customerAddress: data['customerAddress'],
                  customerDeviceToken: data['customerDeviceToken'],
                  customerId: data['customerId'],
                  customerName: data['customerName'],
                  customerPhone: data['customerPhone'],
                  deliveryTime: data['deliveryTime'],
                  fullPrice: data['fullPrice'],
                  isSale: data['isSale'],
                  productDescription: data['productDescription'],
                  productId: data['productId'],
                  productImages: data['productImages'],
                  productName: data['productName'],
                  productQuantity: data['productQuantity'],
                  productTotalPrice: data['productTotalPrice'],
                  salePrice: data['salePrice'],
                  status: data['status'],
                  updatedAt: data['updatedAt'],
                );


                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () => Get.to(
                          () => CheckSingleOrderScreen(
                            docId: docId,
                            orderModel: orderModel,
                          ),
                    ),

                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      child: Text(data['customerNamer'][0],style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    title: Text("${data['productName']}\n${data['productId']}"),
                    subtitle: Text(data['customerPhone']),
                    trailing: Icon(Icons.edit),
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