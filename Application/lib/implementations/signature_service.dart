import 'dart:typed_data';
import 'package:application/extensions/string_extensions.dart';
import 'package:cryptography/cryptography.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';

class SignatureService implements ISignatureService {
  Future<SimpleKeyPair> generateRsaPrivateKey() async {
    final message = <int>[1, 2, 3];

    final algorithm = Ed25519();
    final keyPair = await algorithm.newKeyPair();

    final signature = await algorithm.sign(
      message,
      keyPair: keyPair,
    );

    print('Signature: ${signature.bytes}');
    print('Public key: ${signature.publicKey}');

    final isSignatureCorrect = await algorithm.verify(
      message,
      signature: signature,
    );
    print('Correct signature: $isSignatureCorrect');
    return keyPair;
  }

  Future<Signature> signMessage(KeyPair keyPair, String message) async {
    final algorithm = Ed25519();
    var data = message.toByteList();
    return await algorithm.sign(data, keyPair: keyPair);
  }

  Future<bool> verifySignature(List<int> message, Signature signature) async {
    final algorithm = Ed25519();

    return await algorithm.verify(
      message,
      signature: signature,
    );
  }
}

extension Uint8ListHex on Uint8List {
  String toHex() =>
      map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}
