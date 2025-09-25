## Environment requirements

```
Flutter 3.35.+
Dart SDK: `3.7.0`
Java version: OpenJDK 21.0.7 or compatible
```

**Coplete setup for aither Android or IOS to be able to run application on the real device or simulator**

Please be ready to share Emulator or connected device using [Sharing tool](https://github.com/Genymobile/scrcpy).

Android dependencies:
```
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}
```
IOS requirements:
```
 Xcode 16.3
```

# dna_task_livecoding_flutter_payments

The goal is to implement an app that will work on a POS (point-of-sale) device that will allow to select products from the available set and pay for them with a card.

Task 1:
As an MVP you should enhance product list with functionality to select/unselect product on the list and ...

Task 2:
...be able to buy at least one product (MVP approach).

To perform payment you must:
- initiate purchase transaction
- call payment API using transaction identifier and card token read from reader API
- confirm purchase transaction after successful payment
