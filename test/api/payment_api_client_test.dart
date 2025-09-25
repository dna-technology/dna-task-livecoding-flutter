import 'package:flutter_test/flutter_test.dart';
import 'package:dna_task_livecoding_flutter_payments/api/payment_api_client.dart';
import 'package:dna_task_livecoding_flutter_payments/api/data/payment_request.dart';

void main() {
  group('PaymentApiClient', () {
    late PaymentApiClient paymentApiClient;

    setUp(() {
      paymentApiClient = PaymentApiClient();
    });

    test('correct data - succes', () async {
      // Arrange
      final paymentRequest = PaymentRequest(
        transactionID: 'test-transaction-1',
        amount: 33.66,
        currency: 'EUR',
        cardToken: 'Token',
      );

      // Act
      final response = await paymentApiClient.pay(paymentRequest);

      // Assert
      expect(response.transactionID, equals('test-transaction-1'));
      expect(response.status, equals(PaymentStatus.success));
    });

    test('incorrect amount - failed', () async {
      // Arrange
      final paymentRequest = PaymentRequest(
        transactionID: 'test-transaction-1',
        amount: 19.66,
        currency: 'EUR',
        cardToken: 'Token',
      );

      // Act
      final response = await paymentApiClient.pay(paymentRequest);

      // Assert
      expect(response.transactionID, equals('test-transaction-1'));
      expect(response.status, equals(PaymentStatus.failed));
    });

    test('incorrect currency - failed', () async {
      // Arrange
      final paymentRequest = PaymentRequest(
        transactionID: 'test-transaction-1',
        amount: 19.66,
        currency: 'PLN',
        cardToken: 'Token',
      );

      // Act
      final response = await paymentApiClient.pay(paymentRequest);

      // Assert
      expect(response.transactionID, equals('test-transaction-1'));
      expect(response.status, equals(PaymentStatus.failed));
    });

    test('revert correct amount - success', () async {
      // Arrange
      final paymentRequest = PaymentRequest(
        transactionID: 'test-transaction-1',
        amount: 12.66,
        currency: 'EUR',
        cardToken: 'Token',
      );

      // Act
      final response = await paymentApiClient.revert(paymentRequest);

      // Assert
      expect(response.transactionID, equals('test-transaction-1'));
      expect(response.status, equals(PaymentStatus.success));
    });

    test('revert incorrect amount - failed', () async {
      // Arrange
      final paymentRequest = PaymentRequest(
        transactionID: 'test-transaction-1',
        amount: 0.66,
        currency: 'EUR',
        cardToken: 'Token',
      );

      // Act
      final response = await paymentApiClient.revert(paymentRequest);

      // Assert
      expect(response.transactionID, equals('test-transaction-1'));
      expect(response.status, equals(PaymentStatus.failed));
    });

  });
}
