import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:the_movies/src/shared/models/user_model.dart';
import 'package:the_movies/src/shared/services/firebase/firebase_service.dart';
import 'package:the_movies/src/shared/exceptions/firebase_exception.dart' as fe;

class FirebaseServiceImp implements FirebaseService {
  void _throwFirebaseException(int statusCode, String message) {
    throw fe.FirebaseException(statusCode, message);
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final instance = FirebaseAuth.instance;
      await instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _throwFirebaseException(1, 'Usuário não encontrado');
      } else if (e.code == 'wrong-password') {
        _throwFirebaseException(2, 'Senha incorreta');
      } else if (e.code == 'too-many-requests') {
        _throwFirebaseException(5,
            'Você fez muitas tentativas consecutivas. Aguarde para tentar novamente dentro de alguns minutos.');
      }
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String dateBirthday,
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuth inst = FirebaseAuth.instance;
      await inst.createUserWithEmailAndPassword(email: email, password: password);

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      await users.doc(email).set({
        'name': name,
        'email': email,
        'dateBirthday': dateBirthday,
        'picture': '',
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _throwFirebaseException(4, 'Este email já está sendo utilizado');
        debugPrint('error');
      }
    }
  }

  @override
  Future<void> signOut() async {
    final inst = FirebaseAuth.instance;
    await inst.signOut();
  }

  @override
  Future<UserModel?> userIsLogged() async {
    try {
      final inst = FirebaseAuth.instance;
      User? user = inst.currentUser;
      UserModel? userModel;

      if (user != null) {
        final docUser = FirebaseFirestore.instance.collection('users').doc(userModel!.email);
        final snapshot = await docUser.get();

        userModel = UserModel.fromJson(snapshot.data()!);
      }

      return userModel;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<void> recoveryPassword({required String email}) async {
    try {
      final instance = FirebaseAuth.instance;
      await instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _throwFirebaseException(1, 'Usuário não cadastrado');
      } else if (email.isEmpty) {
        _throwFirebaseException(8, 'Preencha o e-mail');
      }
    }
  }

  @override
  Future<UserModel> getUser() async {
    final inst = FirebaseAuth.instance;
    User? user = inst.currentUser;

    final docUser = FirebaseFirestore.instance.collection('users').doc(user!.uid);
    final snapshot = await docUser.get();

    return UserModel.fromJson(snapshot.data()!);
  }

  @override
  Future<void> updateUser({
    required UserModel userModel,
    String? newPassword,
    String? oldPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance;
      final docUser = FirebaseFirestore.instance.collection("users");

      if (oldPassword != null && oldPassword != '') {
        final credential =
            EmailAuthProvider.credential(email: user.currentUser!.email!, password: oldPassword);
        await user.currentUser!.reauthenticateWithCredential(credential);
        await user.currentUser!.updateEmail(userModel.email);
        if (newPassword != null && newPassword != '') {
          await user.currentUser!.updatePassword(newPassword);
        }
      }

      await docUser.doc().update(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _throwFirebaseException(4, 'Este email já está sendo utilizado');
      } else if (e.code == 'user-not-found') {
        _throwFirebaseException(1, 'Usuário não encontrado');
      } else if (e.code == 'wrong-password') {
        _throwFirebaseException(2, 'Senha antiga incorreta');
      } else if (e.code == 'user-mismatch') {
        _throwFirebaseException(11, 'Email e/ou senha inválidos');
      } else if (e.code == 'requires-recent-login') {
        _throwFirebaseException(10,
            'Esta operação é confidencial e requer autenticação recente. Faça login novamente antes de tentar novamente esta solicitação');
      }
    }
  }

  @override
  Future<UserModel?> verifyAccountExist({required String email}) async {
    try {
      UserModel? userModel;
      final docUser = FirebaseFirestore.instance.collection('users').doc(email);
      final snapshot = await docUser.get();
      userModel = UserModel.fromJson(snapshot.data()!);
      return userModel;
    } catch (e) {
      null;
    }
    return null;
  }
}
