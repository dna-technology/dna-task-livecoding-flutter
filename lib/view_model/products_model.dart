import 'package:dna_task_livecoding_flutter_payments/api/purchase_api_client.dart';
import 'package:flutter/foundation.dart';

class ProductsModel {

  final purchaseApiClient = PurchaseApiClient();

 final ValueNotifier<Map<String, int>> _mutableCart =
      ValueNotifier(<String, int>{});
  ValueListenable<Map<String, int>> get cart => _mutableCart;

  final ValueNotifier<List<Product>> _mutableProducts =
      ValueNotifier<List<Product>>([]);
  ValueListenable<List<Product>> get products => _mutableProducts;


    Future<void> getProducts() async {
      final products = await purchaseApiClient.getProducts();
      _mutableProducts.value = products;
    }

    void addToCart(String productID) {
       final m = Map<String, int>.from(_mutableCart.value);
      m[productID] = (m[productID] ?? 0) + 1;
      _mutableCart.value = m;
    }
}