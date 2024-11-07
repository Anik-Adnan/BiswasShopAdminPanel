
import 'package:biswas_shop_admin_panel/controllers/category_dropdown_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DropDownCategoryWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
        builder: (categoryDropDownController){
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(),
              ),
            ],
          );
        },
    );
  }

}