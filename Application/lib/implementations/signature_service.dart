import 'dart:math';
import 'dart:typed_data';

import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/signers/rsa_signer.dart';

class SignatureService implements ISignatureService {
  Future<String> signAndVerifyMessage(
      RSAPrivateKey privateKey, RSAPublicKey publicKey) async {
    final message = 'Hello, World!';
    final signature = signMessage(privateKey, message);
    final isVerified = verifySignature(publicKey, message, signature);

    print('Message: $message');
    print('Signature: ${signature.bytes.toHex()}');
    print('Signature Verification: $isVerified');
    return signature.bytes.toHex();
  }

  Future<(RSAPrivateKey privateKey, RSAPublicKey publicKey)>
      generateRsaPrivateKey() async {
    final keyGen = RSAKeyGenerator();
    keyGen.init(ParametersWithRandom(
      RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64),
      getSecureRandom(),
    ));
    var keys = keyGen.generateKeyPair();
    keys.publicKey as RSAPublicKey;
    return (keys.privateKey as RSAPrivateKey, keys.publicKey as RSAPublicKey);
  }

  SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
    return secureRandom;
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
