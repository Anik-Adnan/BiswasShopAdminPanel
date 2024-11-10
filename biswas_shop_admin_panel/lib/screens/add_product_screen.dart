


import 'dart:io';

import 'package:biswas_shop_admin_panel/controllers/category_dropdown_controller.dart';
import 'package:biswas_shop_admin_panel/controllers/isSale_controller.dart';
import 'package:biswas_shop_admin_panel/controllers/product_images_controller.dart';
import 'package:biswas_shop_admin_panel/services/generate-Ids.dart';
import 'package:biswas_shop_admin_panel/utils/app_constant.dart';
import 'package:biswas_shop_admin_panel/widgets/dropdown_category_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  ProductImagesController addProductImagesController = Get.put(ProductImagesController());

  CategoryDropDownController categoryDropDownController = Get.put(CategoryDropDownController());
  IsSaleController isSaleController = Get.put(IsSaleController());

  TextEditingController productIdController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0 )),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: SingleChildScrollView(
        physics:BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Images",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0 )),
                    ElevatedButton(
                        onPressed: (){
                          addProductImagesController.showImagesPickerDialog();
                        },
                        child: Text("Select Images",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0 )),),
                  ],
                ),
              ),
        
              //show Images
              GetBuilder<ProductImagesController>(
                init: ProductImagesController(),
                builder: (imageController) {
        
                  return imageController.selectedIamges.length > 0 ?
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: Get.height / 3.0,
                    child: GridView.builder(
                      itemCount: imageController.selectedIamges.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Image.file(
                              File(addProductImagesController
                                  .selectedIamges[index].path),
                              fit: BoxFit.cover,
                              height: Get.height / 4,
                              width: Get.width / 2,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                onTap: () {
                                  imageController.removeImages(index);
                                  print(imageController
                                      .selectedIamges.length);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red.shade700,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                      : SizedBox.shrink();
                },
              ),

              // drop down widget
              DropDownCategoryWidget(),
              //isSale
              GetBuilder<IsSaleController>(
                init: IsSaleController(),
                builder: (isSaleController) {
                  return Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Is Sale",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0 ),),
                          Switch(
                            value: isSaleController.isSale.value,
                            activeColor: AppConstant.appSecondaryColor,
                            onChanged: (value) {
                              isSaleController.toggleIsSale(value);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0,),

              // form
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: productIdController,
                  decoration: InputDecoration(
                    labelText: "Product Id",
                    // labelStyle: TextStyle(color: AppConstant.appMainColor),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Product ID",
                    hintStyle: TextStyle(fontSize: 12.0),
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //   borderSide: BorderSide(color: Colors.grey), // Outline border color when enabled
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //   borderSide: BorderSide(color: AppConstant.appMainColor), // Outline border color when focused
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey), // Default outline border color
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.0,),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: productNameController,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    // labelStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Product Name",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      // borderSide: BorderSide(color: Colors.black)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),

              Obx(
                  (){
                    return isSaleController.isSale.value ?
                    Container(
                      height: 65,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appMainColor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: salePriceController,
                        decoration: InputDecoration(
                          labelText: "Sale Price",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          hintText: "Sale Price",
                          hintStyle: TextStyle(fontSize: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    )
                        : SizedBox.shrink();
                  }
              ),

              SizedBox(height: 10.0,),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: fullPriceController,
                  decoration: InputDecoration(
                    labelText: "Full Price",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: "Full Price",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                height: 400,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.newline,
                  controller: productDescriptionController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Product Descriptions",
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Product Descriptions",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              
              ElevatedButton(
                  onPressed: (){
                    String productId = GenerateIds().generateProductId();
                    print(productId);
                  },
                  child: Text("Upload"),
              ),

            ],
          ),
        ),
      ),

      // body: SingleChildScrollView(
      //   physics: BouncingScrollPhysics(),
      //   child: Container(
      //     child: Column(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text("Select Images"),
      //               ElevatedButton(
      //                 onPressed: () {
      //                   addProductImagesController.showImagesPickerDialog();
      //                 },
      //                 child: Text("Select Images"),
      //               )
      //             ],
      //           ),
      //         ),



      //         //show categories drop down
      //         DropDownCategoriesWiidget(),
      //
      //         //isSale
      //         GetBuilder<IsSaleController>(
      //           init: IsSaleController(),
      //           builder: (isSaleController) {
      //             return Card(
      //               elevation: 10,
      //               child: Padding(
      //                 padding: EdgeInsets.all(8.0),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text("Is Sale"),
      //                     Switch(
      //                       value: isSaleController.isSale.value,
      //                       activeColor: AppConstant.appMainColor,
      //                       onChanged: (value) {
      //                         isSaleController.toggleIsSale(value);
      //                       },
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //         //form
      //         SizedBox(height: 10.0),
      //         Container(
      //           height: 65,
      //           margin: EdgeInsets.symmetric(horizontal: 10.0),
      //           child: TextFormField(
      //             cursorColor: AppConstant.appMainColor,
      //             textInputAction: TextInputAction.next,
      //             controller: productNameController,
      //             decoration: InputDecoration(
      //               contentPadding: EdgeInsets.symmetric(
      //                 horizontal: 10.0,
      //               ),
      //               hintText: "Product Name",
      //               hintStyle: TextStyle(fontSize: 12.0),
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(10.0),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 10.0),
      //
      //         Obx(() {
      //           return isSaleController.isSale.value
      //               ? Container(
      //             height: 65,
      //             margin: EdgeInsets.symmetric(horizontal: 10.0),
      //             child: TextFormField(
      //               cursorColor: AppConstant.appMainColor,
      //               textInputAction: TextInputAction.next,
      //               controller: salePriceController,
      //               decoration: InputDecoration(
      //                 contentPadding: EdgeInsets.symmetric(
      //                   horizontal: 10.0,
      //                 ),
      //                 hintText: "Sale Price",
      //                 hintStyle: TextStyle(fontSize: 12.0),
      //                 border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.all(
      //                     Radius.circular(10.0),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           )
      //               : SizedBox.shrink();
      //         }),
      //
      //         SizedBox(height: 10.0),
      //         Container(
      //           height: 65,
      //           margin: EdgeInsets.symmetric(horizontal: 10.0),
      //           child: TextFormField(
      //             cursorColor: AppConstant.appMainColor,
      //             textInputAction: TextInputAction.next,
      //             controller: fullPriceController,
      //             decoration: InputDecoration(
      //               contentPadding: EdgeInsets.symmetric(
      //                 horizontal: 10.0,
      //               ),
      //               hintText: "Full Price",
      //               hintStyle: TextStyle(fontSize: 12.0),
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(10.0),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //
      //         SizedBox(height: 10.0),
      //         Container(
      //           height: 65,
      //           margin: EdgeInsets.symmetric(horizontal: 10.0),
      //           child: TextFormField(
      //             cursorColor: AppConstant.appMainColor,
      //             textInputAction: TextInputAction.next,
      //             controller: deliveryTimeController,
      //             decoration: InputDecoration(
      //               contentPadding: EdgeInsets.symmetric(
      //                 horizontal: 10.0,
      //               ),
      //               hintText: "Delivery Time",
      //               hintStyle: TextStyle(fontSize: 12.0),
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(10.0),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //
      //         SizedBox(height: 10.0),
      //         Container(
      //           height: 65,
      //           margin: EdgeInsets.symmetric(horizontal: 10.0),
      //           child: TextFormField(
      //             cursorColor: AppConstant.appMainColor,
      //             textInputAction: TextInputAction.next,
      //             controller: productDescriptionController,
      //             decoration: InputDecoration(
      //               contentPadding: EdgeInsets.symmetric(
      //                 horizontal: 10.0,
      //               ),
      //               hintText: "Product Desc",
      //               hintStyle: TextStyle(fontSize: 12.0),
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(10.0),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //
      //         ElevatedButton(
      //           onPressed: () async {
      //             // print(productId);
      //
      //             try {
      //               EasyLoading.show();
      //               await addProductImagesController.uploadFunction(
      //                   addProductImagesController.selectedIamges);
      //               print(addProductImagesController.arrImagesUrl);
      //
      //               String productId = await GenerateIds().generateProductId();
      //
      //               ProductModel productModel = ProductModel(
      //                 productId: productId,
      //                 categoryId: categoryDropDownController.selectedCategoryId
      //                     .toString(),
      //                 productName: productNameController.text.trim(),
      //                 categoryName: categoryDropDownController
      //                     .selectedCategoryName
      //                     .toString(),
      //                 salePrice: salePriceController.text != ''
      //                     ? salePriceController.text.trim()
      //                     : '',
      //                 fullPrice: fullPriceController.text.trim(),
      //                 productImages: addProductImagesController.arrImagesUrl,
      //                 deliveryTime: deliveryTimeController.text.trim(),
      //                 isSale: isSaleController.isSale.value,
      //                 productDescription:
      //                 productDescriptionController.text.trim(),
      //                 createdAt: DateTime.now(),
      //                 updatedAt: DateTime.now(),
      //               );
      //
      //               await FirebaseFirestore.instance
      //                   .collection('products')
      //                   .doc(productId)
      //                   .set(productModel.toMap());
      //               EasyLoading.dismiss();
      //             } catch (e) {
      //               print("error : $e");
      //             }
      //           },
      //           child: Text("Upload"),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}