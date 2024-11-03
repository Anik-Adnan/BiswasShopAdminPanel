
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
        title: Text('Order Id {$customerName}'),
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


                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () => Get.to(
                          () => SpecificCustomerOrderScreen(
                          docId: snapshot.data!.docs[index]['uId'],
                          customerName: snapshot.data!.docs[index]['customerName']),
                    ),

                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      child: Text(data['customerNamer'][0],style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    title: Text(data['customerName']),
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