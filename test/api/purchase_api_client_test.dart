import 'package:flutter_test/flutter_test.dart';
import 'package:dna_task_livecoding_flutter_payments/api/purchase_api_client.dart';
import 'package:dna_task_livecoding_flutter_payments/api/data/purchase_request.dart';

void main() {
  group('PurchaseApiClient', () {
    late PurchaseApiClient purchaseApiClient;

    setUp(() {
      purchaseApiClient = PurchaseApiClient();
    });

    test('get products - succes', () async {

      // Act
      final products = await purchaseApiClient.getProducts();

      // Assert
      expect(products.length, equals(5));
    });

    test('initiate empty order - fail', () async {
      // Arrange
      final purchaseRequest = PurchaseRequest(
       order: <String, int>{}
      );

      // Act
      final purchaseResponse = await purchaseApiClient.initiatePurchaseTransaction(purchaseRequest);

      // Assert
      expect(purchaseResponse.transactionStatus, equals(TransactionStatus.failed));
    });

    test('initiate order with to many items - fail', () async {
      // Arrange
      final purchaseRequest = PurchaseRequest(
       order: <String, int>{ '12345' : 2001}
      );

      // Act
      final purchaseResponse = await purchaseApiClient.initiatePurchaseTransaction(purchaseRequest);

      // Assert
      expect(purchaseResponse.transactionStatus, equals(TransactionStatus.failed));
    });

    test('initiate order with zero items - fail', () async {
      // Arrange
      final purchaseRequest = PurchaseRequest(
       order: <String, int>{ '12345' : 0}
      );

      // Act
      final purchaseResponse = await purchaseApiClient.initiatePurchaseTransaction(purchaseRequest);

      // Assert
      expect(purchaseResponse.transactionStatus, equals(TransactionStatus.failed));
    });

    test('initiate order - confirmed', () async {
      // Arrange
      final purchaseRequest = PurchaseRequest(
       order: <String, int>{ '12345' : 5}
      );

      // Act
      final purchaseResponse = await purchaseApiClient.initiatePurchaseTransaction(purchaseRequest);

      // Assert
      expect(purchaseResponse.transactionStatus, equals(TransactionStatus.initiated));
    });

    test('confirm order with to many items - failed', () async {
      // Arrange
      final purchaseConfirmRequest = PurchaseConfirmRequest(
       order: <String, int>{ '12345' : 2001},
       transactionID: "test-transaction-1"
      );

      // Act
      final purchaseConfrimResponse = await purchaseApiClient.confirm(purchaseConfirmRequest);

      // Assert
      expect(purchaseConfrimResponse.status, equals(TransactionStatus.failed));
    });


  });
}
