import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task/features/auth/login/bloc/login_bloc.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/app_routes.dart';
import 'package:task/core/widgets/app_elevated_button.dart';
import 'package:task/core/widgets/app_snack_bar.dart';
import 'package:task/core/widgets/app_text_button.dart';
import 'package:task/core/widgets/app_text_field.dart';
import 'package:task/features/auth/login/widgets/login_checkbox_text.dart';
import 'package:task/features/auth/login/widgets/login_text_detector.dart';
import 'package:task/services/provider/visibility_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    CircularProgressIndicator;
                  } else if (state is LoginSuccess) {
                    AppSnackBar.show(context, "Giriş Müvəffəqiyyətli!",
                        backgroundColor: AppColors.black);
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.navbar.path);
                  } else if (state is LoginFailure) {
                    AppSnackBar.show(context, "Giriş Uğursuz: ${state.error}");
                  }
                },
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.06),
                      SvgPicture.asset(
                        'assets/images/login_register_logo.svg',
                        width: 200,
                        height: 200,
                      ),
                      const Text(
                        'Welcome back! Glad to see you, Again!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AppTextField(
                            hintText: 'Enter your email',
                            controller: _emailController,
                            obscureText: false,
                            prefixIcon: Icons.email_outlined,
                            onPressed: null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email boş ola bilməz';
                              } else if (!value.endsWith('@gmail.com')) {
                                return 'Email @gmail.com ilə bitməlidir';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Consumer<VisibilityProvider>(
                            builder: (context, visibilityProvider, child) {
                              return AppTextField(
                                hintText: 'Enter your password',
                                controller: _passwordController,
                                obscureText:
                                    visibilityProvider.isObscuredPassword,
                                prefixIcon: Icons.lock_outline,
                                onPressed:
                                    visibilityProvider.togglePasswordVisibility,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Şifrə boş ola bilməz';
                                  } else if (value.length < 6) {
                                    return 'Şifrə ən azı 6 simvol olmalıdır';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const LoginCheckboxText(text: 'Remember me'),
                          AppTextButton(
                            text: 'Forgot password?',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.reset.path);
                            },
                            color: AppColors.lightNavy,
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      AppElevatedButton(
                        text: 'LOG IN',
                        color: AppColors.lightNavy,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            context
                                .read<LoginBloc>()
                                .add(LoginButtonPressed(email, password));
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      LoginTextDetector(
                        text: 'New Member? ',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.register.path);
                        },
                        registerText: 'Register now',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
