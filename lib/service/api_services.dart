import 'dart:convert';

import 'package:http/http.dart';
import 'package:ostad/model/product_model.dart';

class ApiServices{
  final allProduct='http://152.42.163.176:2008/api/v1/ReadProduct';
  Future<List<ProductModel>> getAllProduct() async {
    try {
      Response response = await get(Uri.parse(allProduct));
      print(response.body);
      if(response.statusCode==200){
        Map<String,dynamic> json=jsonDecode(response.body);
        List<dynamic> body=json['data'];
        List<ProductModel> productList=body.map((item) => ProductModel.fromJson(item),).toList();
        return productList;
      }
      else{
        throw('Nothing Found');
      }
    } catch (e) {
      throw (e);
    }
  }
}