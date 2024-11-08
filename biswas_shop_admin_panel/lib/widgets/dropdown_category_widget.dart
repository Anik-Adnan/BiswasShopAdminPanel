
import 'package:biswas_shop_admin_panel/controllers/category_dropdown_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownCategoryWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
        builder: (categoryDropDownController){
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                        value: categoryDropDownController.selectedCategoryId?.value,
                        items: categoryDropDownController.categories.map(
                            (category){
                              return DropdownMenuItem<String>(
                                value: category['categoryId'],
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          category['categoryImg'].toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(category['categoryName'])
                                    ],

                                  )
                              );
                            }
                        ).toList(),
                         onChanged: (String? selectedValue) async {
                          categoryDropDownController.setSelectedCategory(selectedValue);
                          String? categoryName = await categoryDropDownController.getCategoryName(selectedValue);
                          categoryDropDownController.setSelectedCategoryName(categoryName);
                         },
                      hint: const Text(
                        'Select a category',
                      ),
                      isExpanded: true,
                      elevation: 10,
                      underline: const SizedBox.shrink(),

                    ),
                  ),
                ),
              ),
            ],
          );
        },
    );
  }

}