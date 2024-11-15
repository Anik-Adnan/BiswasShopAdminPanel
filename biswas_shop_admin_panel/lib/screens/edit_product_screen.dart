
import 'package:biswas_shop_admin_panel/controllers/category_dropdown_controller.dart';
import 'package:biswas_shop_admin_panel/controllers/edit_product_controller.dart';
import 'package:biswas_shop_admin_panel/model/product-model.dart';
import 'package:biswas_shop_admin_panel/widgets/dropdown_category_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatefulWidget{
  ProductModel productModel;
  EditProductScreen({super.key, required  this.productModel});

  @override
  State<EditProductScreen> createState() => _EditProductControllerState();
  
  
}
class _EditProductControllerState extends State<EditProductScreen>{

  CategoryDropDownController categoryDropDownController = Get.put(CategoryDropDownController());

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
                    GetBuilder<CategoryDropDownController>(
                      init: CategoryDropDownController(),
                      builder: (categoryDropDownController){
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0.0),
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    value: categoryDropDownController.selectedCategoryId?.value,
                                    items: categoryDropDownController.categories?.map(
                                            (category){
                                          // print(category.toString());
                                          return DropdownMenuItem<String>(
                                              value: category['categoryId'],
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
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
                                      // add something here

                                      // print(categoryName);
                                    },
                                    hint:  Text('Select a Category',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0 )),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );


  }

}
