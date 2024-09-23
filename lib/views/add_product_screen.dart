import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad/constant/constamt.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Screen'),
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
                    autovalidateMode: AutovalidateMode
                        .onUserInteraction, //jkhn user data kaita nay tkhn validate kore error day
                    controller: _productCodeTEController,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  // if(_isProgress==true)
                  //   Center(child: CircularProgressIndicator(color: Colors.teal,),)
                  // else
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if(_formKey.currentState!.validate()){
                  //      _addProduct();
                  //     }
                  //   },
                  //   child: const Text('Add'),
                  // ),
                  Visibility(
                    visible: _isProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addProduct();
                        }
                      },
                      child: const Text('Add'),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    _isProgress = true;
    setState(() {});
    const String addNewProductUrl =
        "${baseUrl}CreateProduct";
    Map<String, dynamic> inputProduct = {
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": _productCodeTEController.text,
      "Img": _imageTEController.text,
      "Qty": _quantityTEController.text,
      "UnitPrice": _unitPriceTEController.text,
      "TotalPrice": _totalPriceTEController.text,
    };

    Uri uri = Uri.parse(addNewProductUrl);
    Response response = await post(uri,
        body: jsonEncode(inputProduct),
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    print(response.body);

    print(response.headers);
    _isProgress = false;
    setState(() {});

    if (response.statusCode == 200) {
      _nameTEController.clear();
      _productCodeTEController.clear();
      _unitPriceTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("New Product Added")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("New Product Failed to Add")));
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
