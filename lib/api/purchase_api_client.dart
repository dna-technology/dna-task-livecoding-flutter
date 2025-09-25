import 'package:dna_task_livecoding_flutter_payments/api/data/purchase_request.dart';
import 'package:uuid/uuid.dart';

class PurchaseApiClient {
  final List<Product> productList = [
    Product(
      productID: '12345',
      name: 'Big soda',
      maxAmount: 123,
      unitNetValue: 2.99,
      unitValueCurrency: 'EUR',
      tax: 0.22,
    ),
    Product(
      productID: '12346',
      name: 'Medium soda',
      maxAmount: 30,
      unitNetValue: 1.95,
      unitValueCurrency: 'EUR',
      tax: 0.22,
    ),
    Product(
      productID: '12347',
      name: 'Small soda',
      maxAmount: 1000,
      unitNetValue: 1.25,
      unitValueCurrency: 'EUR',
      tax: 0.22,
    ),
    Product(
      productID: '12348',
      name: 'Chips',
      maxAmount: 2000,
      unitNetValue: 4.33,
      unitValueCurrency: 'EUR',
      tax: 0.22,
    ),
    Product(
      productID: '12349',
      name: 'Snack bar',
      maxAmount: 0,
      unitNetValue: 10.99,
      unitValueCurrency: 'EUR',
      tax: 0.23,
    ),
  ];

  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return productList;
  }

  Future<PurchaseResponse> initiatePurchaseTransaction(
    PurchaseRequest purchaseRequest,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));

    final uuid = Uuid();

    if (purchaseRequest.order.isEmpty) {
      return PurchaseResponse(
        order: purchaseRequest.order,
        transactionID: uuid.v4(),
        transactionStatus: TransactionStatus.failed,
      );
    }

    try {
      double total = 0.0;

      purchaseRequest.order.forEach((productId, qty) {
        final orderedProduct = productList.firstWhere(
          (p) => p.productID == productId,
          orElse: () => throw Exception('Product $productId not found'),
        );

        if (qty <= 0) {
          throw Exception('Not allowed to order non-positive number of items');
        }

        if (qty > orderedProduct.maxAmount) {
          throw Exception('Not allowed to order more than maxAmount');
        }

        total += qty * orderedProduct.unitNetValue * (1.0 + orderedProduct.tax);
      });
      if (total > 0) {
        return PurchaseResponse(
          order: purchaseRequest.order,
          transactionID: uuid.v4(),
          transactionStatus: TransactionStatus.initiated,
        );
      } else {
        return PurchaseResponse(
          order: purchaseRequest.order,
          transactionID: uuid.v4(),
          transactionStatus: TransactionStatus.failed,
        );
      }
    } catch (_) {
      return PurchaseResponse(
        order: purchaseRequest.order,
        transactionID: uuid.v4(),
        transactionStatus: TransactionStatus.failed,
      );
    }
  }

  Future<PurchaseStatusResponse> confirm(
    PurchaseConfirmRequest purchaseRequest,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));

    if (purchaseRequest.order.isEmpty) {
      return PurchaseStatusResponse(
        transactionID: purchaseRequest.transactionID,
        status: TransactionStatus.failed,
      );
    }

    try {
      // Calculate total sum
      final double sum = purchaseRequest.order.entries
          .map((entry) {
            final orderedProduct = productList.firstWhere(
              (product) => product.productID == entry.key,
            );

            if (entry.value <= 0) {
              throw Exception(
                "Not allowed to order non-positive number of items",
              );
            }

            return entry.value *
                orderedProduct.unitNetValue *
                (1.0 + orderedProduct.tax);
          })
          .reduce((a, b) => a + b);

      if (sum > 100.0) {
        return PurchaseStatusResponse(
          transactionID: purchaseRequest.transactionID,
          status: TransactionStatus.failed,
        );
      }

      return PurchaseStatusResponse(
        transactionID: purchaseRequest.transactionID,
        status: TransactionStatus.initiated,
      );
    } catch (e) {
      return PurchaseStatusResponse(
        transactionID: purchaseRequest.transactionID,
        status: TransactionStatus.failed,
      );
    }
  }

  Future<PurchaseStatusResponse> cancel(
    PurchaseCancelRequest purchaseRequest,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return PurchaseStatusResponse(
      transactionID: purchaseRequest.transactionID,
      status: TransactionStatus.canceled,
    );
  }
}

// productID - globally unique product identifier
// name - display name
// maxAmount - available quantity of the product
// unitNetValue - net value of a single item
// unitValueCurrency - currency name
// tax - tax to be added to the net value
class Product {
  final String productID;
  final String name;
  final int maxAmount;
  final double unitNetValue;
  final String unitValueCurrency;
  final double tax;

  const Product({
    required this.productID,
    required this.name,
    required this.maxAmount,
    required this.unitNetValue,
    required this.unitValueCurrency,
    required this.tax,
  });

  @override
  String toString() {
    return '$name[${(unitNetValue * (1.0 + tax)).toStringAsFixed(2)} $unitValueCurrency]';
  }
}
