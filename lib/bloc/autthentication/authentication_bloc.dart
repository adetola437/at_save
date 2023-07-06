
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:at_save/model/user.dart' as adduser;

import '../../shared_preferences/session_manager.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<EmailSignUpEvent>((event, emit) => _emailSignUp(event, emit));
    on<EmailSignInEvent>(
      (event, emit) => _emailSignIn(event, emit),
    );
  }
}

_emailSignUp(EmailSignUpEvent event, emit) async {
  SessionManager manager = SessionManager();
  String? token =await manager.getMessagingToken();

  emit(AuthenticationLoading());
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: event.email, password: event.password);
    final user = adduser.User(
      
        uid: credential.user!.uid,
        email: event.email,
        name: event.name,
        phoneNumber: event.phoneNumber);
    // FlutterWave flutter = FlutterWave();
    // flutter.addFlutterwaveCustomer(event.name, event.phoneNumber, event.email);
    // Monnify server = Monnify();
    // server.createMonnifyCustomer(event.name, event.phoneNumber, event.email);
    //  String fullName = user.name;
    //   List<String> nameParts = fullName.split(' ');

    // final String firstName = nameParts[0];
    // final String lastName = nameParts.length > 1 ? nameParts[1] : '';
    // Paystack pay = Paystack();
    // pay.addCustomerToPaystack(
    //     user.email, firstName, user.phoneNumber, lastName);
    try {
      final CollectionReference reference =
          FirebaseFirestore.instance.collection('users');
      await reference.doc(credential.user!.uid).set(user.toJson());

      // await FirebaseDatabase.instance
      //     .ref()
      //     .child('Users')
      //     .child(credential.user!.uid)
      //     .set(user.toJson());
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    Fluttertoast.showToast(msg: 'Sign Up Successful');
    emit(SignupSuccess(uid: credential.user!.uid));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Fluttertoast.showToast(msg: 'This Password is too weak');
    } else if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(
          msg: 'This account already Exists for this mail',
          gravity: ToastGravity.TOP);
    }

    // Fluttertoast.showToast(
    //       msg: '$e');
    //   log(e.message.toString(), name: 'signup error');
    emit(SignupError(error: e.message!));
  }
}

_emailSignIn(EmailSignInEvent event, emit) async {
  print('Signin');
  emit(AuthenticationLoading());
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    final sharedPreference = SessionManager();
    await sharedPreference.saveUid(credential.user!.uid);
    await sharedPreference.saveEmail(event.email);

    emit(AuthenticationSuccess(uid: credential.user!.uid));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(
          msg: 'This email does not exist', gravity: ToastGravity.TOP);
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(msg: 'Wrong password', gravity: ToastGravity.TOP);
    } else if (e.code == 'user-disabled') {
      Fluttertoast.showToast(
          msg: 'This email has been disabled', gravity: ToastGravity.TOP);
    }
    emit(AuthenticationError(error: '$e'));
  }
}
