import 'package:the_movies/src/shared/models/user_model.dart';

abstract class FirebaseService {
  Future<void> initialize();

  Future<void> signIn({required String email, required String password});

  Future<void> signUp(
      {required String name,
      required String email,
      required String dateBirthday,
      required String password});

  Future<void> signOut();

  Future<void> recoveryPassword({required String email});

  Future<void> updateUser({required UserModel userModel, String? newPassword, String? oldPassword});

  Future<UserModel?> userIsLogged();

  Future<UserModel> getUser();

  Future<UserModel?> verifyAccountExist({required String email});
}
