// Mocks generated by Mockito 5.2.0 from annotations
// in tilla_team/test/auth_bloc_tests/auth_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:http/http.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tilla_team/services/user_service/authApi.dart' as _i2;
import 'package:tilla_team/services/user_service/repo/user_repo.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAuthApi_0 extends _i1.Fake implements _i2.AuthApi {}

class _FakeResponse_1 extends _i1.Fake implements _i3.Response {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i4.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AuthApi get authApi => (super.noSuchMethod(Invocation.getter(#authApi),
      returnValue: _FakeAuthApi_0()) as _i2.AuthApi);
  @override
  set authApi(_i2.AuthApi? _authApi) =>
      super.noSuchMethod(Invocation.setter(#authApi, _authApi),
          returnValueForMissingStub: null);
  @override
  _i5.Future<_i3.Response> login(
          String? username, String? password, String? authLevel) =>
      (super.noSuchMethod(
              Invocation.method(#login, [username, password, authLevel]),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i5.Future<_i3.Response>);
  @override
  _i5.Future<String> register(String? firstName, String? lastName,
          String? username, String? password, String? authLevel) =>
      (super.noSuchMethod(
          Invocation.method(
              #register, [firstName, lastName, username, password, authLevel]),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
}
