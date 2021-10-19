import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/cubit/auth/auth_cubit.dart';
import 'package:kalm/cubit/curhat/curhat_cubit.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_dropdown_button.dart';
import 'package:kalm/widgets/kalm_loading_button.dart';
import 'package:kalm/widgets/kalm_snackbar.dart';
import 'package:kalm/widgets/kalm_switch_button.dart';
import 'package:kalm/widgets/kalm_text_field.dart';

class PostCurhatPage extends StatefulWidget {
  final int userId;

  PostCurhatPage({required this.userId});

  @override
  _PostCurhatPageState createState() => _PostCurhatPageState();
}

class _PostCurhatPageState extends State<PostCurhatPage> {
  final _kontenCurhatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAnonymous = false;
  FocusNode _judulFocus = new FocusNode();
  FocusNode _kontenFocus = new FocusNode();
  String kategori = '';

  @override
  void dispose() {
    super.dispose();
    _judulFocus.dispose();
    _kontenFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurhatCubit>(
          create: (_) => CurhatCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..getUserInfo(GetStorage().read('user_id')),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CurhatCubit, CurhatState>(listener: (context, state) {
            if (state is CurhatPostError) {
              ScaffoldMessenger.of(context).showSnackBar(
                KalmSnackbar(
                  message: state.errorMessage,
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is CurhatPosted) {
              KalmSnackbar(
                message: 'Curhatanmu berhasil dipost',
                duration: Duration(seconds: 2),
              );
              Navigator.of(context).pop();
            }
          }),
          BlocListener<AuthCubit, AuthState>(listener: (authContext, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                KalmSnackbar(
                  message: state.errorMessage,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }),
        ],
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: primaryText,
              ),
            ),
            title: Text(
              'BUAT CURHATAN',
              style: kalmOfflineTheme.textTheme.headline1!
                  .apply(color: primaryText),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: primaryColor,
                            ),
                            SizedBox(width: 8),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return Text(
                                  state is AuthLoadSuccess
                                      ? state.user.name!
                                      : 'User',
                                  style: kalmOfflineTheme.textTheme.button!
                                      .apply(
                                          color: primaryText,
                                          fontSizeFactor: 1.2),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 48,
                          child: KalmDropdownButton(
                            hintText: 'Kategori',
                            primaryColor: tertiaryColor,
                            accentColor: primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            borderColor: primaryColor,
                            width: double.infinity,
                            dropdownItemColor: primaryColor,
                            dropdownData: [
                              {
                                'title': 'Pekerjaan',
                                'value': 'Pekerjaan',
                                'selectedValue': 'Pekerjaan',
                              },
                              {
                                'title': 'Hubungan',
                                'value': 'Hubungan',
                                'selectedValue': 'Hubungan',
                              },
                              {
                                'title': 'Teman',
                                'value': 'Teman',
                                'selectedValue': 'Teman',
                              },
                              {
                                'title': 'Pendidikan',
                                'value': 'Pendidikan',
                                'selectedValue': 'Pendidikan',
                              },
                              {
                                'title': 'Finansial',
                                'value': 'Finansial',
                                'selectedValue': 'Finansial',
                              },
                            ],
                            onChanged: (value) {
                              kategori = value.toString();
                              print(kategori);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: KalmTextField(
                        kalmTextFieldController: _kontenCurhatController,
                        keyboardType: TextInputType.multiline,
                        minLines: 50,
                        hintText: 'Apa yang ingin kamu sampaikan?',
                        focusColor: accentColor,
                        primaryColor: tertiaryColor,
                        accentColor: primaryColor,
                        focusNode: _kontenFocus,
                        validator: (value) {
                          if (value!.isEmpty || value == '') {
                            return 'Kolom curhat tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sembunyikan namaku',
                            style: kalmOfflineTheme.textTheme.bodyText2,
                          ),
                          KalmSwitchButton(
                            primaryColor: primaryColor,
                            accentColor: accentColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.075,
                    ),
                    BlocBuilder<CurhatCubit, CurhatState>(
                      builder: (builderContext, state) {
                        if (state is CurhatLoading)
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: KalmLoadingButton(
                              loadingColor: tertiaryColor,
                              buttonColor: primaryColor,
                            ),
                          );
                        else
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: KalmButton(
                              width: double.infinity,
                              height: 56,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  builderContext
                                      .read<CurhatCubit>()
                                      .postNewCurhat(
                                        GetStorage().read('user_id'),
                                        _isAnonymous,
                                        _kontenCurhatController.text,
                                        kategori,
                                      );
                                }
                              },
                              borderRadius: 10,
                              primaryColor: primaryColor,
                              child: Text(
                                'Kirim Curhat',
                                style: kalmOfflineTheme.textTheme.button!
                                    .apply(color: tertiaryColor),
                              ),
                            ),
                          );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
