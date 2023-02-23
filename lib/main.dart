import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit.dart';
import 'package:todo_app/shared/states.dart';

import 'layout/home-layout.dart';
import 'modules/Tasks/New_task.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>AppCubit()..CreateDatabase(),
        child:BlocConsumer<AppCubit,  AppStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state)
            {

              return MaterialApp(
                theme:ThemeData(
                ),
                debugShowCheckedModeBanner: false,
                home:HoleLayout() ,
                // home:AddTasks() ,

              );
            }
        )
    );
  }
}
