import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/app_texts.dart';
import 'package:task/core/widgets/app_elevated_button.dart';
import 'package:task/core/widgets/app_snack_bar.dart';
import 'package:task/core/widgets/app_text_field.dart';
import 'package:task/features/auth/reset/bloc/reset_password_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title:  const Text(AppTexts.resetYourPassword),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordLoading) {
                    const CircularProgressIndicator();
                  } else if (state is ResetPasswordSuccess) {
                    AppSnackBar.show(
                        context, AppTexts.sendedLink,
                        backgroundColor: Colors.black);
                  } else if (state is ResetPasswordFailure) {
                    AppSnackBar.show(
                        context, 'Yeniləmə Uğursuz: ${state.error}');
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
                              } else if (!value.contains('@')) {
                                return AppTexts.correctEmail;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AppElevatedButton(
                        text: AppTexts.reset,
                        color: AppColors.lightNavy,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            context
                                .read<ResetPasswordBloc>()
                                .add(ResetPasswordRequested(email));
                          }
                        },
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
  }
}
