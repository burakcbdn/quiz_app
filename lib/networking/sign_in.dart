import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential authCredential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
  await firebaseAuth.signInWithCredential(authCredential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = firebaseAuth.currentUser;
    assert(currentUser.uid == user.uid);

    bool isNewUser = true;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((value) {
      print(value);
      isNewUser = !value.exists;
    });

    if (isNewUser) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        "name": currentUser.displayName,
        "profilePictureURL": currentUser.photoURL,
        "id": currentUser.uid,
        "createTime": DateTime.now().millisecondsSinceEpoch,
        "point": 0
      });
    }

    print("Sign in success for ${currentUser.email}");

    return currentUser;
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
}

Future<bool> isSignedIn() {
  return googleSignIn.isSignedIn();
}
