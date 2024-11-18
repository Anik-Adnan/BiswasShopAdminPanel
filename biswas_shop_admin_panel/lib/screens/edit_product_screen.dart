
import 'package:biswas_shop_admin_panel/controllers/category_dropdown_controller.dart';
import 'package:biswas_shop_admin_panel/controllers/edit_product_controller.dart';
import 'package:biswas_shop_admin_panel/controllers/isSale_controller.dart';
import 'package:biswas_shop_admin_panel/model/product-model.dart';
import 'package:biswas_shop_admin_panel/utils/app_constant.dart';
import 'package:biswas_shop_admin_panel/widgets/dropdown_category_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductScreen extends StatefulWidget{
  ProductModel productModel;
  EditProductScreen({super.key, required  this.productModel});

  @override
  State<EditProductScreen> createState() => _EditProductControllerState();
  
  
}
class _EditProductControllerState extends State<EditProductScreen>{
  final isSaleController =Get.put(IsSaleController());

  CategoryDropDownController categoryDropDownController = Get.put(CategoryDropDownController());

  TextEditingController productIdController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productIdController.text = widget.productModel.productId;
    productNameController.text = widget.productModel.productName;
    salePriceController.text = widget.productModel.salePrice;
    fullPriceController.text = widget.productModel.fullPrice;
    deliveryTimeController.text = widget.productModel.deliveryTime;
    productDescriptionController.text = widget.productModel.productDescription;
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<EditProductController>(
        init: EditProductController(productModel: widget.productModel),
        builder: (editProductControler){

          return Scaffold(
            appBar: AppBar(
              title: Text("Edit Product"),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: Get.height / 4.0,
                        child: GridView.builder(
                          itemCount: editProductControler.images.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: editProductControler.images[index],
                                    fit: BoxFit.cover,
                                    height: Get.height / 4,
                                    width: Get.width / 2,
                                    placeholder: (context,url) => Center(child: CupertinoActivityIndicator()),
                                    errorWidget: (context,url,error) => Icon(Icons.error),
                                  ),
                                  Positioned(
                                    right: 2,
                                    top: 2,
                                    child: InkWell(
                                      onTap: () async {
                                        EasyLoading.show();
                                        await editProductControler.deleteImagesFromStorage(editProductControler.images[index].toString());
                                        await editProductControler.deleteImageFromFireStore(editProductControler.images[index].toString(), widget.productModel.productId.toString());

                                        EasyLoading.dismiss();
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
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    // Drop Down Widget
                    DropDownCategoryWidget(),
                    //Is Sale
                    SizedBox(height: 20.0),
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
                    SizedBox(height: 20.0),
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

                    GetBuilder<IsSaleController>(
                      init: IsSaleController(),
                        builder: (isSaleController){
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

                    }),

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
                    SizedBox(height: 10.0,),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style:  ButtonStyle(
                          backgroundColor:  WidgetStatePropertyAll<Color>(
                            Color(0x5514EEFC),
                          ),
                        ),
                          onPressed: () async {
                          EasyLoading.show();

                          ProductModel newProductModel = ProductModel(
                              productId: productIdController.text.trim(),
                              categoryId: categoryDropDownController.selectedCategoryId.toString().trim(),
                              productName: productNameController.text.trim(),
                              categoryName: categoryDropDownController.selectedCategoryName.toString().trim(),
                              salePrice: salePriceController.text != ''
                                  ? salePriceController.text.trim()
                                  : '',
                              fullPrice: fullPriceController.text.trim(),
                              productImages: widget.productModel.productImages,
                              deliveryTime: deliveryTimeController.text.trim(),
                              isSale: isSaleController.isSale.value,
                              productDescription: productDescriptionController.text.trim(),
                              createdAt: widget.productModel.createdAt,
                              updatedAt: DateTime.now()
                          );
                          print("product id: ${widget.productModel.productId.toString()}");

                           // await FirebaseFirestore.instance
                           //    .collection('product')
                           //     .doc(widget.productModel.productId.toString())
                           //     .update(newProductModel.toMap()).catchError((error) => print("Failed to update user: $error"));

                          // Query Firestore using 'where' and update the matching document(s)
                          await FirebaseFirestore.instance
                              .collection('product')
                              .where('productId', isEqualTo: widget.productModel.productId) // Filter condition
                              .get()
                              .then((querySnapshot) async {
                            if (querySnapshot.docs.isNotEmpty) {
                              for (var doc in querySnapshot.docs) {
                                await doc.reference.update(newProductModel.toMap())
                                    .then((_) => print("Document ${doc.id} updated successfully"))
                                    .catchError((error) => print("Failed to update document: $error"));
                              }
                            } else {
                              print("No document found with the specified productId.");
                            }
                          }).catchError((error) => print("Error querying documents: $error"));

                            EasyLoading.dismiss();


                            EasyLoading.dismiss();

                          },
                          child: Text("Save",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black),)
                      ),
                    )


                  ],
                ),
              ),
            ),
          );
        }
    );


  }

}
