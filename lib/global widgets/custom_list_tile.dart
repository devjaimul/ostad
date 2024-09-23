import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad/views/product.dart';
import 'package:ostad/views/product_list.dart';
import '../constant/constamt.dart';
import '../views/update_product_screen.dart';
import 'alert_dialog.dart';

class CustomListTile extends StatefulWidget {
  final Function() onUpdateProduct;
  final Product product;


  const CustomListTile({
    super.key, required this.product, required this.onUpdateProduct,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool _isProgress=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
        widget.product.img,
        errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.error);}),
        title: Text(widget.product.productName),
        subtitle: Wrap(
          spacing: 16,
          children: [
            Text(widget.product.unitPrice.toString()),
            Text(widget.product.qty.toString()),
            Text(widget.product.totalPrice.toString()),
            Text(widget.product.productCode.toString()),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProductScreen(
                      product: widget.product,
                      onUpdateProduct: widget.onUpdateProduct, // Pass the callback function
                    ),
                  ),
                );// Call _getProductList when navigating back

                widget.onUpdateProduct;
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete'),
                    content: const Text('Do You Want to Delete It '),
                    backgroundColor: Colors.grey.shade300,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Delete success')));
                          deleteProductList(widget.product.id);
                        },
                        child: const Text("Yes"),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("No"))
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> deleteProductList(String productID) async {
    setState(() {
      _isProgress = true;  // Show progress indicator
    });

     String deleteProductUrl = baseUrl+"DeleteProduct/$productID";
    Uri uri = Uri.parse(deleteProductUrl);
    Response response = await get(uri);

    print(response.statusCode);  // Debugging the API status
    print(response.body);  // Debugging the API response body

    if (response.statusCode == 200) {
      widget.onUpdateProduct;

    } else {
      setState(() {
        _isProgress = false;  // Hide progress indicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Delete product Failed")),
      );
    }


  }
}
