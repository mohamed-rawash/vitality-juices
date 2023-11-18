
import 'package:drinks_app/core/error/exception.dart';
import 'package:drinks_app/domain/usecase/sign_up_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/usecase/sign_in_usecase.dart';

abstract class BaseUserAuthRemoteDataSource {
  Future<User> signUp(SignUpParameters parameters);
  Future<User> signIn(SignInParameters parameters);
  Future<void> signOut();
  Future<User> googleSignIn();
  Future<void> githubSignIn();
  Future<void> facebookSignIn();
  Future<void> twitterSignIn();
}

class UserAuthRemoteDataSource implements BaseUserAuthRemoteDataSource {
  @override
  Future<void> facebookSignIn() {
    // TODO: implement facebookSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> githubSignIn() {
    // TODO: implement githubSignIn
    throw UnimplementedError();
  }

  @override
  Future<User> googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if(userCredential.user != null) {
        // Once signed in, return the UserCredential
        return userCredential.user!;
      } else {
        throw ServerException(errorMessage: "Failed Login With Google");
      }
    } on FirebaseAuthException catch(e) {
      throw ServerException(errorMessage: e.code.split("-").join(" "));
    } catch (e) {
      throw ServerException(errorMessage: "Failed Login With Google");
    }
  }

  @override
  Future<User> signIn(SignInParameters parameters) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: parameters.email,
          password: parameters.password
      );
      if(credential.user != null) {
        return credential.user!;
      }
      else{
        throw ServerException(errorMessage: "Logging is failure");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException(errorMessage: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw ServerException(errorMessage: "Wrong password provided for that user.");
      }
      throw ServerException(errorMessage: "*******Test ${e.code.split("-").join(" ")}");
    } catch(e) {
      throw ServerException(errorMessage: 'Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      throw ServerException(errorMessage: 'Sign out failed: $error');
    }
  }

  @override
  Future<User> signUp(SignUpParameters parameters) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: parameters.email,
        password: parameters.password,
      );
      if (credential.user == null) {
        throw ServerException(errorMessage: 'Sign up failed: The user is not found after sign up.');
      } else {
        return credential.user!;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ServerException(errorMessage: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw ServerException(errorMessage: "The account already exists for that email.");
      }
      throw ServerException(errorMessage: e.code.split("-").join(" "));
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> twitterSignIn() async {}
  
}