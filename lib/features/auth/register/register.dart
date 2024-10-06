import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/app_texts.dart';
import 'package:task/core/widgets/app_elevated_button.dart';
import 'package:task/features/auth/register/bloc/register_bloc.dart';
import 'package:task/core/constants/app_routes.dart';
import 'package:task/core/widgets/app_snack_bar.dart';
import 'package:task/core/widgets/app_text_field.dart';
import 'package:task/features/auth/register/widgets/register_dialog.dart';
import 'package:task/features/auth/register/widgets/register_text_detector.dart';
import 'package:task/services/provider/visibility_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
              child: BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoading) {
                    const CircularProgressIndicator();
                  } else if (state is RegisterSuccess) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const RegisterDialog();
                      },
                    );
                  } else if (state is RegisterFailure) {
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
                        height: 180,
                      ),
                      const Text(
                        AppTexts.createAccount,
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
                            AppTexts.email,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AppTextField(
                            hintText: AppTexts.enterEmail,
                            controller: _emailController,
                            obscureText: false,
                            prefixIcon: Icons.email_outlined,
                            onPressed: null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppTexts.emptyEmail;
                              } else if (!value.endsWith('@gmail.com')) {
                                return 'Email @gmail.com ilə bitməlidir';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppTexts.password,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Consumer<VisibilityProvider>(
                            builder: (context, visibilityProvider, child) {
                              return AppTextField(
                                hintText: AppTexts.enterPassword,
                                controller: _passwordController,
                                obscureText:
                                    visibilityProvider.isObscuredPassword,
                                prefixIcon: Icons.lock_outline,
                                onPressed:
                                    visibilityProvider.togglePasswordVisibility,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppTexts.emptyPassword;
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
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppTexts.confirm,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Consumer<VisibilityProvider>(
                            builder: (context, visibilityProvider, child) {
                              return AppTextField(
                                hintText: AppTexts.confirmPassword,
                                controller: _confirmPasswordController,
                                obscureText: visibilityProvider
                                    .isObscuredConfirmPassword,
                                prefixIcon: Icons.lock_outline,
                                onPressed: visibilityProvider
                                    .toggleConfirmPasswordVisibility,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppTexts.emptyPassword;
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
                      const SizedBox(height: 20),
                      AppElevatedButton(
                        text: AppTexts.signUp,
                        color: AppColors.lightNavy,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            final confirmPassword =
                                _confirmPasswordController.text.trim();
                            if (password != confirmPassword) {
                              AppSnackBar.show(context, AppTexts.samePassword);
                            } else {
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterButtonPressed(email, password));
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      RegisterTextDetector(
                        text: AppTexts.alreadyMember,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.login.path);
                        },
                        loginText: AppTexts.logIn,
                      )
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
    _confirmPasswordController.dispose();
  }
}
