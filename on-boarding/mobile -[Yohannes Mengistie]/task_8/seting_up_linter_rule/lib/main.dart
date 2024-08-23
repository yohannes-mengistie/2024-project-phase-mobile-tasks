import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'feature/authentication/presentation/bloc/authentication_bloc.dart';

import 'feature/authentication/presentation/pages/splash_screen.dart';

import 'feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter engine is initialized
  Bloc.observer = SimpleBlocObserver();
  await di.init(); // Initializes dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<ECommerceBloc>()),
          BlocProvider(create: (context) => di.sl<AuthenticationBloc>())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const SplashScreen(),
        ));
  }
}
