import 'package:at_save/shared_preferences/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:at_save/model/user.dart' as adduser;

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpWithEmail(
   
      String email, String password, String name, String phoneNumber) async {
    try {
       print('Signing up');
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = adduser.User(
        uid: credential.user!.uid,
        email: email,
        name: name,
        phoneNumber: phoneNumber,
      );

      final CollectionReference reference = _firestore.collection('users');
      await reference.doc(credential.user!.uid).set(user.toJson());

      Fluttertoast.showToast(msg: 'Sign Up Successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'This Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'This account already Exists for this mail',
          gravity: ToastGravity.TOP,
        );
      }
      throw e;
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
      throw e;
    }
  }
   Future<void> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final sharedPreference = SessionManager();
      await sharedPreference.saveUid(credential.user!.uid);
      await sharedPreference.saveEmail(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'This email does not exist',
          gravity: ToastGravity.TOP,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password',
          gravity: ToastGravity.TOP,
        );
      } else if (e.code == 'user-disabled') {
        Fluttertoast.showToast(
          msg: 'This email has been disabled',
          gravity: ToastGravity.TOP,
        );
      }
      throw e;
    } catch (e) {
      // Handle network connection error
      Fluttertoast.showToast(
        msg: 'Network connection error',
        gravity: ToastGravity.TOP,
      );
      throw e;
    }
  }
}
