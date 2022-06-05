import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tilla_team/application/auth/auth_bloc.dart';
import 'package:tilla_team/domain/domain.dart';
import 'package:tilla_team/services/services.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  group("LoginFlow", () {
    test(
        "Emit states accordingly -> AuthInitial -> AuthLoading -> Authenticated when login successful",
        () async {
      final fakeUser = User(
          id: '',
          firstName: 'Root',
          lastName: 'User',
          username: 'rootuser@email.com',
          password: 'rootUserPass',
          authLevel: 'native');

      final authBloc = AuthBloc(userRepository: mockUserRepository);

      final response = mockUserRepository.login(
          fakeUser.username, fakeUser.password, fakeUser.authLevel);

      authBloc.add(
          SignInAuth(fakeUser.username, fakeUser.password, fakeUser.authLevel));

      expectLater(
        authBloc.stream,
        emitsInOrder(
          [
            AuthLoading(),
            Authenticated(response.toString()),
          ],
        ),
      );
    });
  });
}
