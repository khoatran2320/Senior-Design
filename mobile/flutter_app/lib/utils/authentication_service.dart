import 'package:authentication_riverpod/models/authModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final authenticationProvider = Provider<Authentication>(
    (ref) => Authentication());

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authenticationProvider).authStateChange);

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  bool isLoggedIn() {
    User? user = _firebaseAuth.currentUser;
    print(user);
    return user == null ? false : true;
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      print('Sign In Here!');
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Sign In Success!');
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      print('Sign Up here');
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      user?.updateDisplayName(name);
      print('Sign up success');
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      print('Error');
      return e.message;
    }
  }
}
