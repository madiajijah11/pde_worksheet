import 'package:jwt_decoder/jwt_decoder.dart';

class JWT {
  Map<String, dynamic> decodeToken(String token) {
    return JwtDecoder.decode(token);
  }
}
