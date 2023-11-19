import 'dart:convert';

import 'package:cryptography/cryptography.dart';

class Ed25519KeyPair {
  final SimpleKeyPair keyPair;

  Ed25519KeyPair(this.keyPair);

  Future<Map<String, dynamic>> toJson() async {
    var privateKey = await keyPair.extractPrivateKeyBytes();
    var publicKey = await keyPair.extractPublicKey();
    return {
      'privateKey': base64Encode(privateKey),
      'publicKey': base64Encode(publicKey.bytes),
    };
  }

  factory Ed25519KeyPair.fromJson(Map<String, dynamic> json) {
    final privateKey = base64Decode(json['privateKey']);
    final publicKey = base64Decode(json['publicKey']);
    var key = SimpleKeyPairData(
      privateKey,
      publicKey: SimplePublicKey(publicKey, type: KeyPairType.ed25519),
      type: KeyPairType.ed25519,
    );
    return Ed25519KeyPair(key);
  }
}
