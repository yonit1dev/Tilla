import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tilla_team/domain/domain.dart';
import 'package:tilla_team/services/user_service/authApi.dart';

void main() {
  AuthApi sut = AuthApi();

  setUp(() {
    sut = AuthApi();
  });

  var mockUser = User(
    id: '',
    firstName: 'Root',
    lastName: 'User',
    username: 'rootUser@email.com',
    password: 'rootUserPass',
    authLevel: 'native',
  );

  group('Login', () {
    test('Return JSON Token when login successful', () async {
      var result = await sut.login(
          mockUser.username, mockUser.password, mockUser.authLevel);

      expect(result.statusCode, 200);
    });
  });
}
