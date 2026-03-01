import 'package:Bitmark/data/models/app_user.dart';
import 'package:Bitmark/data/data_sources/auth_data_source.dart';
import 'package:Bitmark/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class FakeAuthCredential extends Fake implements AuthCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleSignInAccount mockGoogleUser;
  late MockGoogleSignInAuthentication mockGoogleAuth;
  late AuthDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(FakeAuthCredential());
  });

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleUser = MockGoogleSignInAccount();
    mockGoogleAuth = MockGoogleSignInAuthentication();

    dataSource = AuthDataSource(
      auth: mockFirebaseAuth,
      google: mockGoogleSignIn,
    );

    when(() => mockUser.uid).thenReturn(MockData.id);
    when(() => mockUser.email).thenReturn(MockData.email);
    when(() => mockUser.displayName).thenReturn(MockData.name);
    when(() => mockUser.reload()).thenAnswer((_) async => {});
    when(() => mockUser.metadata).thenReturn(UserMetadata(0, 0));
    when(() => mockUser.delete()).thenAnswer((_) async => {});
    when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async => {});
    when(() => mockUserCredential.user).thenReturn(mockUser);
  });

  group('AuthDataSource', () {
    test('getUser()', () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      final user = dataSource.getUser();
      expect(user, isA<AppUser>());
    });

    test('getAuthState()', () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.emailVerified).thenReturn(true);
      final result = dataSource.getAuthState();
      expect(result, AuthState.auth);
    });

    test('signIn(String email, String password)', () async {
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: MockData.email,
          password: MockData.password,
        ),
      ).thenAnswer((_) async => mockUserCredential);
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.emailVerified).thenReturn(true);
      final result = await dataSource.signIn(MockData.email, MockData.password);
      expect(result, true);
    });

    test('signUp(String name, String email, String password)', () async {
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: MockData.email,
          password: MockData.password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final user = await dataSource.signUp(
        MockData.name,
        MockData.email,
        MockData.password,
      );
      expect(user, isA<AppUser>());
    });

    test('signOut()', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => {});
      when(() => mockGoogleSignIn.currentUser).thenReturn(null);
      await dataSource.signOut();
      verify(() => mockFirebaseAuth.signOut()).called(1);
    });

    test('sendEmailVerification()', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(
        () => mockUser.sendEmailVerification(any()),
      ).thenAnswer((_) async => {});
      await dataSource.sendEmailVerification();
      verify(() => mockUser.sendEmailVerification(any())).called(1);
    });

    test('checkEmailVerification()', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async => {});
      when(() => mockUser.emailVerified).thenReturn(true);
      final result = await dataSource.checkEmailVerification();
      expect(result, true);
    });

    test('sendPasswordResetEmail(String email)', () async {
      when(
        () => mockFirebaseAuth.sendPasswordResetEmail(email: MockData.email),
      ).thenAnswer((_) async => {});
      await dataSource.sendPasswordResetEmail(MockData.email);
      verify(
        () => mockFirebaseAuth.sendPasswordResetEmail(email: MockData.email),
      ).called(1);
    });

    test('deleteAccount()', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      await dataSource.deleteAccount();
      verify(() => mockUser.delete()).called(1);
    });

    test('signInWithGoogle()', () async {
      when(
        () => mockGoogleSignIn.signIn(),
      ).thenAnswer((_) async => mockGoogleUser);
      when(
        () => mockGoogleUser.authentication,
      ).thenAnswer((_) async => mockGoogleAuth);
      when(() => mockGoogleAuth.accessToken).thenReturn('');
      when(() => mockGoogleAuth.idToken).thenReturn('');
      when(
        () => mockFirebaseAuth.signInWithCredential(any()),
      ).thenAnswer((_) async => mockUserCredential);
      when(
        () => mockUserCredential.additionalUserInfo,
      ).thenReturn(MockAdditionalUserInfo(true));
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      final result = await dataSource.signInWithGoogle();
      expect(result, isA<AppUser>());
    });
  });
}

class MockAdditionalUserInfo extends Mock implements AdditionalUserInfo {
  final bool _isNewUser;

  MockAdditionalUserInfo(this._isNewUser);

  @override
  bool get isNewUser => _isNewUser;
}
