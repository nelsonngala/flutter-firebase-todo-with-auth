import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_todo/data/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(
    this._authRepository,
  ) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signIn(event.email, event.password);
        return emit(AuthenticatedState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(AuthenticationError(error: e.message.toString()));
        } else if (e.code == 'wrong-password') {
          emit(AuthenticationError(error: e.message.toString()));
        }
      } catch (e) {
        emit(AuthenticationError(error: '$e'));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signUp(event.email, event.password);
        emit(AuthenticatedState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(const AuthenticationError(
              error: 'Please choose a stronger password'));
        } else if (e.code == 'email-already-in-use') {
          emit(const AuthenticationError(
              error:
                  'A user with that email exists, please enter a different one, or sign in if you have an account.'));
        }
      } catch (e) {
        emit(AuthenticationError(error: '$e'));
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signInWithGoogle();
        return emit(AuthenticatedState());
      } catch (e) {
        emit(AuthenticationError(error: '$e'));
      }
    });
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      await _authRepository.signOut();
      return emit(AuthInitial());
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.resetPassword(event.email);
        return emit(PasswordResetState());
      } catch (e) {
        emit(AuthenticationError(error: '$e'));
      }
    });
  }
}
