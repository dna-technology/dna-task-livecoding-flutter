import 'package:uuid/uuid.dart';

class CardReaderService {
  Future<CardData> readCard() async {

     final int second = DateTime.now().second;

  if (second <= 30) {
    await Future.delayed(const Duration(seconds: 4));

    final String id = const Uuid().v4(); 
    return CardData(token: id);
  }

  throw CardReaderException();
  }
}

class CardData {
  final String token;

  CardData({required this.token});
}

class CardReaderException implements Exception {
  final String message;
  CardReaderException([this.message = 'Could not read card data']);

  @override
  String toString() => 'CardReaderException: $message';
}