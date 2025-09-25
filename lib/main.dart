import 'package:dna_task_livecoding_flutter_payments/api/purchase_api_client.dart';
import 'package:dna_task_livecoding_flutter_payments/view_model/products_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNATaskAndroid',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProductsView(),
    );
  }
}

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductsModel productsModel = ProductsModel();

  @override
  void initState() {
    super.initState();
    productsModel.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Product>>(
      valueListenable: productsModel.products, // listen here
      builder: (context, products, _) {
        return SafeArea(
          child: Scaffold(body: ProductsListView(products: products)),
        );
      },
    );
  }
}

class ProductsListView extends StatefulWidget {
  const ProductsListView({super.key, required this.products});

  final List<Product> products;

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text("Products list", style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    widget.products[index].toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
