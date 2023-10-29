import 'dart:typed_data';

import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/signers/rsa_signer.dart';

class Authentication implements ISignatureService {
  Future<void> signAndVerifyMessage() async {
    var keys = await generateRsaPrivateKey();
    final publicKey = keys.$2;

    final message = 'Hello, World!';
    final signature = signMessage(keys.$1, message);
    final isVerified = verifySignature(publicKey, message, signature);

    print('Message: $message');
    print('Signature: ${signature.bytes.toHex()}');
    print('Signature Verification: $isVerified');
  }

  Future<(RSAPrivateKey publicKey, RSAPublicKey privateKey)>
      generateRsaPrivateKey() async {
    final keyGen = RSAKeyGenerator()
      ..init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64),
        SecureRandom('Fortuna'),
      ));

    var keys = keyGen.generateKeyPair();
    keys.publicKey as RSAPublicKey;
    return (keys.privateKey as RSAPrivateKey, keys.publicKey as RSAPublicKey);
  }

  RSASignature signMessage(RSAPrivateKey privateKey, String message) {
    final signer = RSASigner(SHA256Digest(), '0609608648016503040201');
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    final signature =
        signer.generateSignature(Uint8List.fromList(message.codeUnits));
    return signature;
  }

  bool verifySignature(
      RSAPublicKey publicKey, String message, RSASignature signature) {
    final verifier = RSASigner(SHA256Digest(), '0609608648016503040201');
    verifier.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
    return verifier.verifySignature(
        Uint8List.fromList(message.codeUnits), signature);
  }
}

extension Uint8ListHex on Uint8List {
  String toHex() =>
      map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}
