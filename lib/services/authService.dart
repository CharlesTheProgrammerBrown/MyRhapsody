import 'package:firebase_auth/firebase_auth.dart';

// abstract class AuthAction {
//   Future<User> registerWithEmailAndPassword(
//       String email, String password, String name);
//   Future<User> signInWithEmailAndPassword(String email, String password);
//   Future<void> signOut();
//   Future<User> signInWithGoogle();
//   bool isSignedIn();
//   User getCurrentUser();
// }

class AuthService {
  User firebaseuser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      user.updateProfile(displayName: name);

      // await firebaseAuth
      //     .createUserWithEmailAndPassword(email: email, password: password)
      //     .then((userValue) => {firebaseuser = userValue.user});
      // firebaseuser.updateProfile(displayName: name);
      print("reaches here");

      //return firebaseuser;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredentialvalue) =>
              {firebaseuser = userCredentialvalue.user});
      return firebaseuser;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    return Future.wait([
      firebaseAuth.signOut(),
    ]);
  }

  bool isSignedIn() {
    final currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  String getCurrentUser() {
    return firebaseAuth.currentUser.uid;
  }
}
