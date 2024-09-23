import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad/constant/constamt.dart';
import 'package:ostad/global%20widgets/custom_list_tile.dart';
import 'package:ostad/model/product_model.dart';
import 'package:ostad/service/api_services.dart';
import 'package:ostad/views/add_product_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ostad/views/product.dart';

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
      body: RefreshIndicator(
        onRefresh: _getProductList, // Refresh product list on swipe
        child: Visibility(
          visible: _isprogress==false,
          replacement: Center(child: CircularProgressIndicator(color: Colors.teal,)),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                product: productList[index], onUpdateProduct: () {  },
              );
            },
          ),
        )
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

    const String getProductUrl = baseUrl+"ReadProduct";
    Uri uri = Uri.parse(getProductUrl);
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
