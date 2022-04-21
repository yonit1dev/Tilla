import '../../service/user_credential.dart';

class Mapper {
  static Map<String, dynamic> toJson(UserCredential userCredential) => {
        "fullName": userCredential.fullName,
        "email": userCredential.email,
        "password": userCredential.password,
      };
}
