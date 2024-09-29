
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.my_flutter_app/cubits/login_cubit.dart';

class LoginForm extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(16.0),
			child: Form(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						TextFormField(
							key: Key('emailField'),
							decoration: InputDecoration(labelText: 'Email'),
						),
						TextFormField(
							key: Key('passwordField'),
							decoration: InputDecoration(labelText: 'Password'),
							obscureText: true,
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								final email = (context.findRenderObject() as RenderObjectWithChildMixin<RenderObject>).widget as TextFormField;
								final password = (context.findRenderObject() as RenderObjectWithChildMixin<RenderObject>).widget as TextFormField;
								context.read<LoginCubit>().login(email.controller!.text, password.controller!.text);
							},
							child: Text('Login'),
						),
					],
				),
			),
		);
	}
}
