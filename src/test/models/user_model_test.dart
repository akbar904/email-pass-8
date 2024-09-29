
import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_app/models/user_model.dart';

void main() {
	group('User Model', () {
		test('should create a User model with given email and password', () {
			final user = User(email: 'test@example.com', password: 'password123');

			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});

		test('should serialize to JSON correctly', () {
			final user = User(email: 'test@example.com', password: 'password123');
			final json = user.toJson();

			expect(json, {
				'email': 'test@example.com',
				'password': 'password123',
			});
		});

		test('should deserialize from JSON correctly', () {
			final json = {
				'email': 'test@example.com',
				'password': 'password123',
			};
			final user = User.fromJson(json);

			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});
	});
}
