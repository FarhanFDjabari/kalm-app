import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/presentation/widgets/kalm_dialog.dart';
import 'package:kalm/presentation/widgets/kalm_dropdown_button.dart';
import 'package:kalm/presentation/widgets/kalm_loading_button.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/kalm_text_button.dart';
import 'package:kalm/presentation/widgets/kalm_text_field.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/routes/route_name.dart';
import 'package:open_mail_app/open_mail_app.dart';

class Register extends StatefulWidget {
  final PageController pageController;

  Register({required this.pageController});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String jenisKelamin = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (authContext, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            KalmSnackbar(
              duration: Duration(seconds: 2),
              message: state.errorMessage,
            ),
          );
          _isLoading = false;
        } else if (state is AuthLoading) {
          _isLoading = true;
        } else if (state is AuthRegisterSuccess) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   KalmSnackbar(
          //     duration: Duration(seconds: 2),
          //     message: 'Registrasi Berhasil!',
          //   ),
          // );
          // Navigator.pushNamedAndRemoveUntil(
          //     context, RouteName.HOME, (route) => false);
          _isLoading = false;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => KalmDialog(
              title: 'Registrasi Berhasil',
              subtitle:
                  'Silahkan cek email kamu untuk melakukan konfirmasi sebelum masuk ke aplikasi',
              successButtonTitle: 'Oke',
              onSuccess: () async {
                Navigator.of(context).pop();
                await OpenMailApp.openMailApp();
              },
            ),
          );
        }
      },
      builder: (builderContext, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  Image.asset(
                    'assets/picture/kalm-font-only-logo.png',
                    scale: 1.8,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Daftar',
                    textAlign: TextAlign.center,
                    style: kalmOfflineTheme.textTheme.subtitle2!
                        .apply(color: tertiaryColor, fontSizeFactor: 1.5),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Silahkan masukkan data berikut \nuntuk membuat akun',
                    textAlign: TextAlign.center,
                    style: kalmOfflineTheme.textTheme.subtitle2!
                        .apply(color: tertiaryColor, fontSizeFactor: 1.1),
                  ),
                  SizedBox(height: 24),
                  KalmTextField(
                    kalmTextFieldController: nameController,
                    minLines: 1,
                    maxLines: 1,
                    hintText: 'Nama Lengkap',
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    focusColor: tertiaryColor.withOpacity(0.2),
                    primaryColor: tertiaryColor.withOpacity(0.2),
                    accentColor: tertiaryColor,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Kolom nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  KalmTextField(
                    kalmTextFieldController: emailController,
                    minLines: 1,
                    maxLines: 1,
                    hintText: 'Email/Username',
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
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
                    inputAction: TextInputAction.next,
                    focusColor: tertiaryColor.withOpacity(0.2),
                    primaryColor: tertiaryColor.withOpacity(0.2),
                    accentColor: tertiaryColor,
                    suffixIcon: Icons.visibility_outlined,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Kolom password tidak boleh kosong';
                      } else if (value.length <= 8) {
                        return 'Password harus memiliki lebih dari 8 karakter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  KalmDropdownButton(
                    hintText: 'Jenis Kelamin',
                    primaryColor: tertiaryColor.withOpacity(0.2),
                    accentColor: tertiaryColor,
                    dropdownColor: secondaryText.withOpacity(0.5),
                    dropdownItemColor: tertiaryColor,
                    width: double.infinity,
                    dropdownData: [
                      {
                        'title': 'Laki - laki',
                        'value': 'Laki - laki',
                        'selectedValue': 'Laki - laki',
                      },
                      {
                        'title': 'Perempuan',
                        'value': 'Perempuan',
                        'selectedValue': 'Perempuan',
                      },
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Kolom jenis kelamin tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      jenisKelamin = value.toString();
                    },
                  ),
                  SizedBox(height: 24),
                  if (_isLoading)
                    KalmLoadingButton(
                      loadingColor: primaryColor,
                      buttonColor: tertiaryColor,
                    ),
                  if (!_isLoading)
                    KalmButton(
                      width: double.infinity,
                      height: 56,
                      borderRadius: 10,
                      primaryColor: tertiaryColor,
                      child: Text(
                        'Daftar',
                        style: kalmOfflineTheme.textTheme.button!
                            .apply(color: primaryColor),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          builderContext.read<AuthCubit>().register(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                                jenisKelamin,
                              );
                        }
                      },
                    ),
                  SizedBox(height: 10),
                  KalmTextButton(
                    primaryColor: accentColor,
                    width: double.infinity,
                    height: 20,
                    borderRadius: 10,
                    onPressed: () {
                      widget.pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeOut,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun? ',
                          style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                            color: tertiaryColor.withOpacity(0.8),
                            fontSizeFactor: 1.2,
                          ),
                        ),
                        Text(
                          'Masuk',
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
          ),
        );
      },
    );
  }
}
