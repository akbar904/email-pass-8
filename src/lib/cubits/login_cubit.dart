
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Define the states
abstract class LoginState extends Equatable {
	const LoginState();

	@override
	List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}

// Define the LoginCubit
class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		emit(LoginLoading());
		try {
			// Simulate a login process with a delay
			await Future.delayed(const Duration(seconds: 1));
			if (email == 'test@example.com' && password == 'password123') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure());
			}
		} catch (e) {
			emit(LoginFailure());
		}
	}
}
