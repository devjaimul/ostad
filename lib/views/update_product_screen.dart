import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad/constant/constamt.dart';
import 'package:ostad/views/product.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;
  final Function onUpdateProduct;
  const UpdateProductScreen({super.key, required this.product, required this.onUpdateProduct});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isprogress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTEController.text = widget.product.productName;
    _productCodeTEController.text = widget.product.productCode.toString();
    _unitPriceTEController.text = widget.product.unitPrice.toString();
    _quantityTEController.text = widget.product.qty.toString();
    _totalPriceTEController.text = widget.product.totalPrice.toString();
    _imageTEController.text = widget.product.img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode
                        .onUserInteraction, //jkhn user data kaita nay tkhn validate kore error day
                    controller: _nameTEController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter Product Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _unitPriceTEController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Product Code',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter Product Code';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _unitPriceTEController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Unit price',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter Product Unit Price';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _quantityTEController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter Product Quantity';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _totalPriceTEController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Total Price',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter Product Total Price';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _imageTEController,
                    decoration: const InputDecoration(
                      labelText: 'Image',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter Product Image';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Visibility(
                    visible: _isprogress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateProduct();


                        }
                      },
                      child: const Text('Update'),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _isprogress = true;
    setState(() {});
    Map<String, dynamic> inputData = {
      "ProductName": _nameTEController.text,
      "ProductCode": _productCodeTEController.text,
      "Img": _imageTEController.text,
      "Qty": _quantityTEController.text,
      "UnitPrice": _unitPriceTEController.text,
      "TotalPrice": _totalPriceTEController.text,
    };
    String updateUrl = baseUrl + "UpdateProduct/${widget.product.id}";
    Uri uri = Uri.parse(updateUrl);
    Response response = await post(uri,
        headers: {"content-type": "application/json"},
        body: jsonEncode(inputData));

    if(response.statusCode==200){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product Updated Succesfully")));
      Navigator.pop(context,true);
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unsuccesful Try Again!")));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
