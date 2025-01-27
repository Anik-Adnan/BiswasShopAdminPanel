
import 'package:biswas_shop_admin_panel/controllers/count_all_user_controller.dart';
import 'package:biswas_shop_admin_panel/model/UserModel.dart';
import 'package:biswas_shop_admin_panel/utils/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final CountAllUserController _getUserCount =
  Get.put(CountAllUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
              'All User(${_getUserCount.userCount.toString()})');
        }),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .orderBy('createdOn', descending: true)
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
                child: Text('No users found!'),
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

                UserModel userModel = UserModel(
                  uId: data['uId'],
                  userName: data['userName'],
                  email: data['email'],
                  phone: data['phone'],
                  userImg: data['userImg'],
                  userDeviceToken: data['userDeviceToken'],
                  userCity: data['userCity'],
                  country: data['country'],
                  userAddress: data['userAddress'],
                  street: data['street'],
                  isAdmin: data['isAdmin'],
                  isActive: data['isActive'],
                  createdOn: data['createdOn'],
                );

                return Card(
                  elevation: 5,
                  child: ListTile(
                    // onTap: () => Get.to(
                    //   () => SpecificCustomerOrderScreen(
                    //       docId: snapshot.data!.docs[index]['uId'],
                    //       customerName: snapshot.data!.docs[index]
                    //           ['customerName']),
                    // ),

                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      backgroundImage: CachedNetworkImageProvider(
                        userModel.userImg,
                        errorListener: (err) {
                          // Handle the error here
                          print('Error loading image');
                          Icon(Icons.error);
                        },
                      ),
                    ),
                    title: Text(userModel.userName),
                    subtitle: Text(userModel.email),
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