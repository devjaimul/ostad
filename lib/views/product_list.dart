import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad/global%20widgets/custom_list_tile.dart';
import 'package:ostad/model/product_model.dart';
import 'package:ostad/service/api_services.dart';
import 'package:ostad/views/add_product_screen.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _isprogress = false;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Visibility(
        replacement: const Center(
          child: CircularProgressIndicator(
            color: Colors.teal,
          ),
        ),
        visible: !_isprogress, // Using negation here for better readability
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return CustomListTile(
              productName: productList[index].productName,
              unitPrice: productList[index].unitPrice.toString(),
              quantity: productList[index].qty.toString(),
              totalPrice: productList[index].totalPrice.toString(),
              image: productList[index].img,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    setState(() {
      _isprogress = true;  // Show progress indicator
    });

    const String baseUrl = "http://152.42.163.176:2008/api/v1/ReadProduct";
    Uri uri = Uri.parse(baseUrl);
    Response response = await get(uri);

    print(response.statusCode);  // Debugging the API status
    print(response.body);  // Debugging the API response body

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      if (decodedData.containsKey('data')) {
        final jsonProductList = decodedData['data'];

        productList.clear(); // Clear the list before adding new data

        for (Map<String, dynamic> p in jsonProductList) {
          Product product = Product(
            id: p['_id'] ?? '',
            productName: p['ProductName'] ?? '',
            productCode: p['ProductCode'] ?? '',
            unitPrice: p['UnitPrice'] ?? '',
            qty: p['Qty'] ?? '',
            totalPrice: p['TotalPrice'] ?? '',
            img: p['Img'] ?? '',
          );
          productList.add(product);
        }
      } else {
        print("Key 'data' not found in the response");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data Fetching Failed")),
      );
    }

    setState(() {
      _isprogress = false;  // Hide progress indicator
    });
  }
}

class Product {
  final String id;
  final String productName;
  final int productCode;
  final int unitPrice;
  final int qty;
  final int totalPrice;
  final String img;

  Product({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.unitPrice,
    required this.qty,
    required this.totalPrice,
    required this.img,
  });
}
