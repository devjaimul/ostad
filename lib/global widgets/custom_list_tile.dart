import 'package:flutter/material.dart';
import '../views/update_product_screen.dart';
import 'alert_dialog.dart';

class CustomListTile extends StatelessWidget {
  final String productName;
  final String unitPrice;
  final String quantity;
  final String totalPrice;
  final String image;

  const CustomListTile({
    super.key,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
        image,
        errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.error);}),
        title: Text(productName),
        subtitle: Wrap(
          spacing: 16,
          children: [
            Text(unitPrice),
            Text(quantity),
            Text(totalPrice),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProductScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                const CustomAlertDialog();
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
}
