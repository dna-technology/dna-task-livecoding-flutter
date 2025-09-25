class PurchaseRequest {
  final Map<String, int> order;

  PurchaseRequest({required this.order});
}

class PurchaseResponse {
  final Map<String, int> order;
  final String transactionID;
  final TransactionStatus transactionStatus;

  PurchaseResponse({
    required this.order,
    required this.transactionID,
    required this.transactionStatus,
  });
}

class PurchaseConfirmRequest {
  final Map<String, int> order;
  final String transactionID;

  PurchaseConfirmRequest({
    required this.order,
    required this.transactionID,
  });
}

class PurchaseCancelRequest {
  final String transactionID;

  PurchaseCancelRequest({required this.transactionID});
}

class PurchaseStatusResponse {
  final String transactionID;
  final TransactionStatus status;

  PurchaseStatusResponse({
    required this.transactionID,
    required this.status,
  });
}

enum TransactionStatus {
  initiated,
  confirmed,
  canceled,
  failed
}
