
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/screens/login_screen.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('displays LoginForm widget', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(
				home: Scaffold(
					body: LoginScreen(),
				),
			));

			expect(find.byType(LoginForm), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		late MockLoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		blocTest<MockLoginCubit, LoginState>(
			'emits LoginState.loading and then LoginState.success when login is successful',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginState.loading());
					await Future.delayed(Duration(milliseconds: 500));
					cubit.emit(LoginState.success());
				});
				cubit.login('test@example.com', 'password');
			},
			expect: () => [
				LoginState.loading(),
				LoginState.success(),
			],
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits LoginState.loading and then LoginState.failure when login fails',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginState.loading());
					await Future.delayed(Duration(milliseconds: 500));
					cubit.emit(LoginState.failure('Login failed'));
				});
				cubit.login('test@example.com', 'wrongpassword');
			},
			expect: () => [
				LoginState.loading(),
				LoginState.failure('Login failed'),
			],
		);
	});
}
