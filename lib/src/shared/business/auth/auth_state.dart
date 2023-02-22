import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthInitState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSucessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthFailureState extends AuthState {
  final String errorMessage;
  AuthFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [errorMessage];
}

class AuthSendEmailState extends AuthState {
  final String sendMessage;
  AuthSendEmailState({this.sendMessage = 'O e-mail de recuperação foi enviado'});
  @override
  List<Object?> get props => [sendMessage];
}
