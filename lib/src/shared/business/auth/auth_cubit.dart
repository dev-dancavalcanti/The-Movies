import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/exceptions/firebase_exception.dart' as fe;
import 'package:the_movies/src/shared/business/auth/auth_state.dart';
import 'package:the_movies/src/shared/models/user_model.dart';
import 'package:the_movies/src/shared/repositories/auth/auth_repositories.dart';
import 'package:the_movies/src/shared/routes/routes.dart';

class AuthCubit extends Cubit<AuthState> {
  late AuthRepository _authRepository;
  AuthCubit() : super(AuthInitState()) {
    _initialize();
  }

  late UserModel? _userLogged;
  UserModel? get userLogged => _userLogged;
  void setUser(UserModel? value) => _userLogged = value;

  Future<void> _initialize() async {
    emit(AuthLoadingState());
    _authRepository = Modular.get<AuthRepository>();
    await _authRepository.initialize();
    _userLogged = await _authRepository.userIsLogged();
    emit(AuthInitState());
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoadingState());
    _authRepository.signIn(email: email, password: password)
      ..catchError((error, stackTrace) async {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is fe.FirebaseException) errorMessage = error.message;
        emit(AuthFailureState(errorMessage: errorMessage));
      })
      ..then((val) async {
        if (state is! AuthFailureState) {
          emit(AuthSucessState());
          Modular.to.navigate('/${Routes.movies}');
          _userLogged = await _authRepository.userIsLogged();
          //TODO: Nav Home
        }
      });
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String dateBirthday,
  }) async {
    emit(AuthLoadingState());
    _authRepository.signUp(
      name: name,
      email: email,
      password: password,
      dateBirthday: dateBirthday,
    )
      ..catchError((error, stackTrace) async {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is fe.FirebaseException) errorMessage = error.message;
        emit(AuthFailureState(errorMessage: errorMessage));
      })
      ..then((value) async {
        if (state is! AuthFailureState) {
          //TODO: Nav Home
        }
      });
  }

  Future<void> signOut() async {
    emit(AuthLoadingState());

    _authRepository.signOut()
      ..then((val) async {
        if (state is! AuthFailureState) {
          _userLogged = null;
          //TODO: Nav Auth
        }
      })
      ..catchError((error, stackTrace) {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is fe.FirebaseException) errorMessage = error.message;
        emit(AuthFailureState(errorMessage: errorMessage));
      });
  }

  Future<void> recoveryPassword(String email) async {
    emit(AuthLoadingState());
    _authRepository.recoveryPassword(email: email)
      ..catchError((error, stackTrace) async {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is fe.FirebaseException) errorMessage = error.message;
        emit(AuthFailureState(errorMessage: errorMessage));
      })
      ..then((val) async {
        if (state is! AuthFailureState) {
          emit(AuthSendEmailState());
        }
      });
  }

  Future<UserModel?> verifyUser({required String email}) async {
    _userLogged = await _authRepository.verifyUser(email: email);
    if (_userLogged != null) {
      emit(AuthSucessState());
    }
    return _userLogged;
  }

  void userNull() {
    _userLogged = null;

    emit(AuthLoadingState());
  }
}
