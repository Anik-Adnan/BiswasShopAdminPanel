
import 'package:biswas_shop_admin_panel/controllers/edit_product_controller.dart';
import 'package:biswas_shop_admin_panel/model/product-model.dart';
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
                  ],
                ),
              ),
            ),
          );
        }
    );


  }

}
