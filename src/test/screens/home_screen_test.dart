
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/screens/home_screen.dart';
import 'package:my_flutter_app/cubits/home_cubit.dart';

// Mocking HomeCubit
class MockHomeCubit extends MockCubit<void> implements HomeCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late MockHomeCubit mockHomeCubit;

		setUp(() {
			mockHomeCubit = MockHomeCubit();
		});

		testWidgets('should display a logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<HomeCubit>(
						create: (_) => mockHomeCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('should call logout on cubit when logout button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<HomeCubit>(
						create: (_) => mockHomeCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Logout'));
			await tester.pump();

			verify(() => mockHomeCubit.logout()).called(1);
		});
	});
}
