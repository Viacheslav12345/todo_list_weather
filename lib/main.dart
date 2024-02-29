import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_weather/data/services/local_storage_service.dart';
import 'package:todo_list_weather/data/services/weather_service.dart';
import 'package:todo_list_weather/presentation/to_do/to_do_list_bloc/to_do_list_bloc.dart';
import 'package:todo_list_weather/presentation/to_do_list_screen.dart';
import 'package:todo_list_weather/presentation/weather/weather_cubit/weather_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ToDoListBloc(LocalStorageServiceImpl(sharedPreferences: prefs))
                ..add(GetTaskList()),
        ),
        BlocProvider(
          create: (context) => WeatherCubit(WeatherService())
            ..onLoadForecast(
                '32.0588', '49.444444'), // Coordinates of city Cherkassy
        )
      ],
      child: MaterialApp(
        title: 'To Do List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
          useMaterial3: true,
        ),
        home: const ToDoListScreen(title: 'To Do List'),
      ),
    );
  }
}
