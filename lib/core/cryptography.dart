import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

class Cryptography {
  final String _fernetKey = "KMqjJx7w4frzELAJpg8nQUPFb4sPnPx6dIe5X1s9TwQ=";

  String FernetEncryption(String text) {
    final key = encrypt.Key.fromBase64(_fernetKey);

    final b64key = encrypt.Key.fromBase64(base64Url.encode(key.bytes));

    final fernet = encrypt.Fernet(b64key);

    final encrypter = encrypt.Encrypter(fernet);

    return encrypter.encrypt(text).base64;
  }
}
