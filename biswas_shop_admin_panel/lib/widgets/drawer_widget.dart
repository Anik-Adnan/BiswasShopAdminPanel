

import 'package:biswas_shop_admin_panel/screens/all_orders_screen.dart';
import 'package:biswas_shop_admin_panel/screens/all_products_screens.dart';
import 'package:biswas_shop_admin_panel/screens/all_users_Screens.dart';
import 'package:biswas_shop_admin_panel/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget{
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();

}
class _DrawerWidgetState extends State<DrawerWidget>{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Wrap(
        runSpacing: 10.0,
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Biswas Shop",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("version 1.0.1"),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appSecondaryColor,
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('B'),
                  ),
                ),

              )
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 1.5,
            color: Colors.grey,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.home),
              )
          ),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Users",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.person),
                onTap: (){
                  Get.to(()=> AllUsersScreen());
                },
              )
          ),

           Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Products",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.production_quantity_limits),
                onTap: (){
                  Get.to(()=> AllProductsScreen());
                },
              )
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Orders",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.shopping_bag),
                onTap: (){
                  // Get.back();
                  Get.to(()=>AllOrdersScreen());
                },
              )
          ),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Reviews",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.reviews),
                onTap: (){
                  // Get.back();
                  // Get.to(()=>AllOrderScreen());
                },
              )
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Categories",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.category),
              )
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Contact Us",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.help_center),
              )
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Logout",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: const Icon(Icons.logout),
                onTap: () async{
                  // GoogleSignIn googleSignIn = GoogleSignIn();
                  // FirebaseAuth auth = FirebaseAuth.instance;
                  // await auth.signOut();
                  // await googleSignIn.signOut();
                  // Get.offAll(()=> WelcomeScreen());
                },
              )
          ),

        ],
      ),
    );
  }

}