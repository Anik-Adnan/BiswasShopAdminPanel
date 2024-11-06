
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
                String orderDocId = data.id;

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
                            docId: snapshot.data!.docs[index].id,
                            orderModel: orderModel,
                          ),
                    ),

                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      child: Text(data['customerName'][0].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    title: Text("${data['productName']}\n${data['productId']}"),
                    subtitle: Text(data['customerPhone']),
                    trailing: InkWell(
                      onTap: (){
                        showDeliveryDetails(
                          userDocId: docId,
                          orderModel: orderModel,
                          orderDocId: orderDocId,
                        );

                      },
                        child: Icon(Icons.more_vert)),
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

  void showDeliveryDetails({
    required String userDocId,
    required OrderModel orderModel,
    required String orderDocId,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text('Update Delivery Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select the delivery status'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(userDocId)
                          .collection('confirmOrders')
                          .doc(orderDocId)
                          .update({'status': false});
                      Get.back(); // Close the dialog
                    },
                    child: Text('Pending',style: TextStyle(color: Colors.black),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(userDocId)
                          .collection('confirmOrders')
                          .doc(orderDocId)
                          .update({'status': true});
                      Get.back(); // Close the dialog
                    },
                    child: Text('Delivered',style: TextStyle(color: Colors.black),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




}