import 'package:flutter/material.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
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
                    autovalidateMode: AutovalidateMode.onUserInteraction, //jkhn user data kaita nay tkhn validate kore error day
                    controller: _nameTEController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                    ),
                    validator: (String? value){
                      if(value==null||value.trim().isEmpty){
                        return 'Enter Product Name';
                      }
                      else{
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
                    validator: (String? value){
                      if(value==null||value.trim().isEmpty){
                        return 'Enter Product Unit Price';
                      }
                      else{
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
                    validator: (String? value){
                      if(value==null||value.trim().isEmpty){
                        return 'Enter Product Quantity';
                      }
                      else{
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
                    validator: (String? value){
                      if(value==null||value.trim().isEmpty){
                        return 'Enter Product Total Price';
                      }
                      else{
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
                    validator: (String? value){
                      if(value==null||value.trim().isEmpty){
                        return 'Enter Product Image';
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){

                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              )),
        ),
      ),
    );
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
