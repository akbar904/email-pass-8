
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/main.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}
class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('MyApp initializes and displays LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			// Verify that the LoginScreen is displayed
			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});

	group('Cubit State Management', () {
		late MockLoginCubit mockLoginCubit;
		late MockHomeCubit mockHomeCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
			mockHomeCubit = MockHomeCubit();
		});

		blocTest<MockLoginCubit, LoginState>(
			'LoginCubit emits correct states',
			build: () => mockLoginCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => <LoginState>[
				LoginLoading(),
				LoginSuccess(user: User(email: 'test@example.com', password: 'password123')),
			],
		);

		blocTest<MockHomeCubit, HomeState>(
			'HomeCubit emits correct states',
			build: () => mockHomeCubit,
			act: (cubit) => cubit.logout(),
			expect: () => <HomeState>[
				HomeInitial(),
				HomeLoggedOut(),
			],
		);
	});
}
