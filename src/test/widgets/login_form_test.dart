
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.my_flutter_app/widgets/login_form.dart';

// Mock classes
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

// Entry point for the tests
void main() {
	group('LoginForm Widget Tests', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		tearDown(() {
			loginCubit.close();
		});

		testWidgets('should display email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>(
						create: (_) => loginCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>(
						create: (_) => loginCubit,
						child: LoginForm(),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('should call login when login button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>(
						create: (_) => loginCubit,
						child: LoginForm(),
					),
				),
			);

			final emailField = find.byKey(Key('emailField'));
			final passwordField = find.byKey(Key('passwordField'));
			final loginButton = find.byType(ElevatedButton);

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password');
			await tester.tap(loginButton);

			verify(() => loginCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
