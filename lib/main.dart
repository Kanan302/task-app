import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task/features/auth/pages/register/bloc/register_bloc.dart';
import 'package:task/features/auth/pages/login/bloc/login_bloc.dart';
import 'package:task/core/constants/app_routes.dart';
import 'package:task/features/auth/pages/login/login.dart';
import 'package:task/features/auth/pages/register/register.dart';
import 'package:task/features/auth/pages/reset/bloc/reset_password_bloc.dart';
import 'package:task/features/auth/pages/reset/reset_password.dart';
import 'package:task/features/splash/splash.dart';
import 'package:task/features/home.dart';
import 'package:task/firebase_options.dart';
import 'package:task/providers/visibility_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VisibilityProvider(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ResetPasswordBloc(firebaseAuth: FirebaseAuth.instance),
        ),
      ],
      child: MaterialApp(
        title: 'Task App',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash.path,
        routes: {
          AppRoutes.splash.path: (context) => const SplashPage(),
          AppRoutes.login.path: (context) => const LoginPage(),
          AppRoutes.register.path: (context) => const RegisterPage(),
          AppRoutes.reset.path: (context) => const ResetPasswordPage(),
          AppRoutes.home.path: (context) => const HomePage(),
        },
      ),
    );
  }
}
