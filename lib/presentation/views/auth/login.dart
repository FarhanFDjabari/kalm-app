import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/presentation/widgets/kalm_loading_button.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/kalm_text_button.dart';
import 'package:kalm/presentation/widgets/kalm_text_field.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/routes/route_name.dart';

class Login extends StatefulWidget {
  final PageController pageController;

  Login({required this.pageController});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (authContext, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            KalmSnackbar(
              message: state.errorMessage,
              duration: Duration(seconds: 2),
            ),
          );
          _isLoading = false;
        } else if (state is AuthLoading) {
          _isLoading = true;
        } else if (state is AuthLoginSuccess) {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            KalmSnackbar(
              message: 'Login Berhasil!',
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.HOME, (route) => false);
        }
      },
      builder: (builderContext, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Image.asset(
                  'assets/picture/kalm-font-only-logo.png',
                  scale: 1.8,
                ),
                SizedBox(height: 30),
                Text(
                  'Masuk',
                  style: kalmOfflineTheme.textTheme.subtitle2!
                      .apply(color: tertiaryColor, fontSizeFactor: 1.5),
                ),
                SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Silahkan masuk menggunakan akun Kalm Anda',
                    textAlign: TextAlign.center,
                    style: kalmOfflineTheme.textTheme.subtitle2!
                        .apply(color: tertiaryColor, fontSizeFactor: 1.1),
                  ),
                ),
                SizedBox(height: 24),
                KalmTextField(
                  kalmTextFieldController: emailController,
                  minLines: 1,
                  maxLines: 1,
                  hintText: 'Email/Username',
                  keyboardType: TextInputType.emailAddress,
                  focusColor: tertiaryColor.withOpacity(0.2),
                  primaryColor: tertiaryColor.withOpacity(0.2),
                  accentColor: tertiaryColor,
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'Kolom email/username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                KalmTextField(
                  kalmTextFieldController: passwordController,
                  minLines: 1,
                  maxLines: 1,
                  hintText: 'Password',
                  isObscure: true,
                  keyboardType: TextInputType.visiblePassword,
                  focusColor: tertiaryColor.withOpacity(0.2),
                  primaryColor: tertiaryColor.withOpacity(0.2),
                  accentColor: tertiaryColor,
                  suffixIcon: Icons.visibility_outlined,
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'Kolom password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                if (_isLoading)
                  KalmLoadingButton(
                    buttonColor: tertiaryColor,
                    loadingColor: primaryColor,
                  ),
                if (!_isLoading)
                  KalmButton(
                    width: double.infinity,
                    height: 56,
                    borderRadius: 10,
                    primaryColor: tertiaryColor,
                    child: Text(
                      'Login',
                      style: kalmOfflineTheme.textTheme.button!
                          .apply(color: primaryColor),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        builderContext.read<AuthCubit>().login(
                            emailController.text, passwordController.text);
                      }
                    },
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                KalmTextButton(
                  primaryColor: accentColor,
                  width: double.infinity,
                  height: 20,
                  borderRadius: 10,
                  onPressed: () {
                    widget.pageController.animateToPage(
                      2,
                      duration: Duration(milliseconds: 750),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                          color: tertiaryColor.withOpacity(0.8),
                          fontSizeFactor: 1.2,
                        ),
                      ),
                      Text(
                        'Daftar',
                        style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                          color: tertiaryColor,
                          fontSizeFactor: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
