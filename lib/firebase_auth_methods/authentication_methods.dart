import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
UserCredential? userCredentials;
User? user;
bool userCreated = false;

Future UserSignup(
    {required String name,
    required String email,
    required String password,
    required String confirmPassword}) async {
  try {
    userCredentials = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    user = userCredentials?.user;

    if (user != null) {
      user?.updateEmail(email);
      user?.updateDisplayName(name);

      firestore.collection('users').doc(auth.currentUser!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      });

      // Get.toNamed('/home');
    }
    userCreated = true;
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Account has been created. Login to continue.',
        duration: Duration(seconds: 2),
      ),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      userCreated = false;
      Get.showSnackbar(
        const GetSnackBar(
          message: 'The account already exists on this email.',
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

Future UserSignIn({required String email, required String password}) async {
  try {
    userCredentials =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredentials?.user;
    if (user != null) {
      Get.toNamed('/home');
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Failed to Login. Try Again.',
          duration: Duration(seconds: 2),
        ),
      );
    }
  } on Exception catch (e) {
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Failed to Login. Try Again.',
        duration: Duration(seconds: 2),
      ),
    );
  }
}
