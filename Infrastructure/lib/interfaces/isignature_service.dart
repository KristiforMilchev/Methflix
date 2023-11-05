import 'package:pointycastle/pointycastle.dart';

abstract class ISignatureService {
  Future<String> signAndVerifyMessage(
    RSAPrivateKey privateKey,
    RSAPublicKey publicKey,
  );
  Future<(RSAPrivateKey publicKey, RSAPublicKey privateKey)>
      generateRsaPrivateKey();
  RSASignature signMessage(RSAPrivateKey privateKey, String message);
  bool verifySignature(
      RSAPublicKey publicKey, String message, RSASignature signature);
}
