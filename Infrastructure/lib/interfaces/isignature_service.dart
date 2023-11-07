import 'package:cryptography/cryptography.dart';

abstract class ISignatureService {
  Future<SimpleKeyPair> generateRsaPrivateKey();
  Future<Signature> signMessage(KeyPair keyPair, String message);
  Future<bool> verifySignature(List<int> message, Signature signature);
}
