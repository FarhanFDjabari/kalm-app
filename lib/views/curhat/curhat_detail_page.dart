import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/cubit/curhat/curhat_cubit.dart';
import 'package:kalm/model/curhat/detail_curhat_model.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_curhat_reply_tile.dart';
import 'package:kalm/widgets/kalm_detail_curhat_tile.dart';
import 'package:kalm/widgets/kalm_snackbar.dart';
import 'package:kalm/widgets/kalm_switch_button.dart';
import 'package:kalm/widgets/kalm_text_field.dart';

class CurhatDetailPage extends StatefulWidget {
  final int curhatId;

  CurhatDetailPage({required this.curhatId});

  @override
  _CurhatDetailPageState createState() => _CurhatDetailPageState();
}

class _CurhatDetailPageState extends State<CurhatDetailPage> {
  final _replyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAnonymous = false;

  @override
  void dispose() {
    super.dispose();
    _replyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurhatCubit>(
      create: (context) => CurhatCubit()
        ..getCurhatDetail(GetStorage().read('user_id'), widget.curhatId),
      child: BlocListener<CurhatCubit, CurhatState>(
        listener: (context, state) {
          if (state is CurhatPostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is CurhatLoadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is CommentPosted) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: 'Behasil mengirim komentar',
                duration: Duration(seconds: 2),
              ),
            );
            context
                .read<CurhatCubit>()
                .getCurhatDetail(GetStorage().read('user_id'), widget.curhatId);
          }
        },
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
              'CURHAT',
              style: kalmOfflineTheme.textTheme.headline1!
                  .apply(color: primaryText),
            ),
          ),
          body: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 1,
                right: 1,
                child: Image.asset(
                  'assets/picture/picture-background_bottom_middle.png',
                  scale: 1.5,
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<CurhatCubit, CurhatState>(
                builder: (builderContext, state) {
                  if (state is DetailCurhatLoaded)
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: KalmDetailCurhatTile(
                            user: state.detailCurhatan.user!,
                            content: state.detailCurhatan.content!,
                            topic: state.detailCurhatan.category!,
                            postedAt: state.detailCurhatan.createdAt,
                            likeCount: state.detailCurhatan.curhatLike!,
                            isAnonymous: state.detailCurhatan.isAnonymous,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Balasan',
                                    style: kalmOfflineTheme.textTheme.bodyText2!
                                        .apply(
                                            color: primaryText,
                                            fontSizeFactor: 1.1),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    ' (${state.detailCurhatan.comments!.length})',
                                    style: kalmOfflineTheme.textTheme.bodyText2!
                                        .apply(
                                            color: primaryText,
                                            fontSizeFactor: 1.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RefreshIndicator(
                              onRefresh: () async {},
                              color: primaryColor,
                              child: ListView.builder(
                                itemCount:
                                    state.detailCurhatan.comments!.length,
                                itemBuilder: (_, index) {
                                  DetailComment komentar =
                                      state.detailCurhatan.comments![index];
                                  return KalmCurhatReplyTile(
                                    comment: komentar.content ?? '-',
                                    userName: komentar.username ?? '-',
                                    postedAt: komentar.createdAt,
                                    isAnonymous: komentar.isAnonymous,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.17,
                          color: tertiaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          margin: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Sembunyikan namaku',
                                      style:
                                          kalmOfflineTheme.textTheme.bodyText2,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                    ),
                                    KalmSwitchButton(
                                      primaryColor: primaryColor,
                                      accentColor: accentColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _isAnonymous = value;
                                        });
                                        print('is anonymous: $value');
                                      },
                                      value: _isAnonymous,
                                    ),
                                  ],
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: KalmTextField(
                                        kalmTextFieldController:
                                            _replyController,
                                        minLines: 1,
                                        keyboardType: TextInputType.multiline,
                                        hintText:
                                            'Berkomentar sebagai Selene...',
                                        focusColor: primaryColor,
                                        primaryColor: accentColor,
                                        accentColor: secondaryText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Kolom komentar tidak boleh kosong';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          builderContext
                                              .read<CurhatCubit>()
                                              .postComment(
                                                GetStorage().read('user_id'),
                                                widget.curhatId,
                                                _replyController.text,
                                                _isAnonymous,
                                              );
                                          _replyController.clear();
                                        }
                                      },
                                      child: Container(
                                        child: Icon(
                                          Iconsax.send_2,
                                          size: 28,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  else
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
