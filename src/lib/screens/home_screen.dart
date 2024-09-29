
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/cubits/home_cubit.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
			),
			body: Center(
				child: ElevatedButton(
					onPressed: () {
						BlocProvider.of<HomeCubit>(context).logout();
					},
					child: Text('Logout'),
				),
			),
		);
	}
}
