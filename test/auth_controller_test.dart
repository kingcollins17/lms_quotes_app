import 'package:firebase_auth/firebase_auth.dart';
import 'package:lms_quotes_app/controllers/auth_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<User>(), MockSpec<UserCredential>()])
import 'auth_controller_test.mocks.dart';

void main() {
  late MockFirebaseAuth auth;
  late AuthController controller;
  setUp(() {
    auth = MockFirebaseAuth();
    controller = AuthController(auth: auth, inTestMode: true);
  });
  group('Test AuthController', () {
    test('createUser', () async {
      final mockUser = MockUser();
      final mockCred = MockUserCredential();

      when(auth.currentUser).thenReturn(mockUser);
      when(mockCred.user).thenReturn(mockUser);

      when(auth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockCred);

      expect(controller.isAuthenticated, isFalse); //expect we are not authenticated yet
      await controller.createUser(email: 'jondoe@gmail.com', password: 'password123');
      expect(controller.isAuthenticated, isTrue); //expect that we are now authenticated
    });


    test('loginUser', () async {
      final mockUser = MockUser();
      final mockCred = MockUserCredential();

      when(auth.currentUser).thenReturn(mockUser);
      when(mockCred.user).thenReturn(mockUser);

      when(auth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockCred);

      expect(controller.isAuthenticated, isFalse); //expect we are now authenticated initally
      await controller.loginUser(email: 'jondoe@gmail.com', password: 'password');

      expect(controller.isAuthenticated, isTrue); //expect we are now authenticated
    });
  });
}
