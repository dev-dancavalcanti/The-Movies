import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/models/user_model.dart';
import 'package:the_movies/src/shared/services/firebase/firebase_service.dart';

class AuthRepository {
  late FirebaseService _firebaseService;

  Future<void> initialize() async {
    _firebaseService = Modular.get<FirebaseService>();
    _firebaseService.initialize();
  }

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseService.signIn(email: email, password: password);
  }

  Future<void> recoveryPassword({required String email}) async {
    await _firebaseService.recoveryPassword(email: email);
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String dateBirthday,
  }) async {
    await _firebaseService.signUp(
      name: name,
      email: email,
      password: password,
      dateBirthday: dateBirthday,
    );
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
  }

  Future<UserModel?> userIsLogged() async {
    return await _firebaseService.userIsLogged();
  }

  Future<UserModel?> verifyUser({required String email}) async {
    return await _firebaseService.verifyAccountExist(email: email);
  }
}
