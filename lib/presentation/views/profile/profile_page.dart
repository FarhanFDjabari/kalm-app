import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/auth/auth_cubit.dart';
import 'package:kalm/presentation/views/profile/header_image.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/presentation/widgets/kalm_loading_button.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/kalm_text_field.dart';
import 'package:kalm/styles/kalm_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();

  @override
  void initState() {
    context.read<AuthCubit>().getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (listenerContext, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            KalmSnackbar(
              message: state.errorMessage,
              duration: Duration(seconds: 2),
            ),
          );
        }
        if (state is AuthSaveSuccess) {
          listenerContext.read<AuthCubit>().getCurrentUser();
        }
      },
      child: Scaffold(
        backgroundColor: accentColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: primaryText,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'PROFILE',
            style: kalmOfflineTheme.textTheme.headline1!.apply(
              color: primaryText,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (builderContext, state) {
                  if (state is AuthLoadSuccess) {
                    final userData = state.user;
                    _emailController.text = userData.email ?? "-";
                    _nameController.text = userData.name ?? "-";
                    _usernameController.text = userData.username ?? "-";
                    _genderController.text = userData.jenisKelamin ?? "-";
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HeaderImage(),
                        const SizedBox(height: 8),
                        Divider(
                          color: primaryColor,
                          thickness: 0.5,
                        ),
                        const SizedBox(height: 8),
                        KalmTextField(
                          kalmTextFieldController: _emailController,
                          minLines: 1,
                          maxLines: 1,
                          isEnable: false,
                          hintText: 'Email',
                          focusColor: tertiaryColor.withOpacity(0.2),
                          primaryColor: secondaryText.withOpacity(0.5),
                          accentColor: tertiaryText,
                        ),
                        const SizedBox(height: 10),
                        KalmTextField(
                          kalmTextFieldController: _nameController,
                          minLines: 1,
                          maxLines: 1,
                          isEnable: false,
                          hintText: 'Nama Lengkap',
                          focusColor: tertiaryColor.withOpacity(0.2),
                          primaryColor: secondaryText.withOpacity(0.5),
                          accentColor: tertiaryText,
                        ),
                        const SizedBox(height: 10),
                        KalmTextField(
                          kalmTextFieldController: _usernameController,
                          minLines: 1,
                          maxLines: 1,
                          hintText: 'Username',
                          keyboardType: TextInputType.name,
                          inputAction: TextInputAction.next,
                          focusColor: primaryColor.withOpacity(0.5),
                          primaryColor: primaryColor.withOpacity(0.5),
                          accentColor: tertiaryColor,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'Kolom username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        KalmTextField(
                          kalmTextFieldController: _genderController,
                          minLines: 1,
                          maxLines: 1,
                          isEnable: false,
                          hintText: 'Jenis Kelamin',
                          focusColor: tertiaryColor.withOpacity(0.2),
                          primaryColor: secondaryText.withOpacity(0.5),
                          accentColor: tertiaryText,
                        ),
                        const SizedBox(height: 24),
                        if (state is AuthLoading)
                          KalmLoadingButton(
                            buttonColor: primaryColor,
                            loadingColor: tertiaryColor,
                          ),
                        if (!(state is AuthLoading))
                          KalmButton(
                            width: double.infinity,
                            height: 56,
                            borderRadius: 10,
                            primaryColor: primaryColor,
                            child: Text(
                              'Simpan',
                              style: kalmOfflineTheme.textTheme.button!
                                  .apply(color: tertiaryColor),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                builderContext
                                    .read<AuthCubit>()
                                    .updateUserProfile(
                                      GetStorage().read('user_id'),
                                      _usernameController.text,
                                      null,
                                    );
                              }
                            },
                          ),
                      ],
                    );
                  }
                  return Center(
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CircularProgressIndicator(
                          color: tertiaryColor,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
