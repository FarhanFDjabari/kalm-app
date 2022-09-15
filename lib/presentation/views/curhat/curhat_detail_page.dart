import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_comment_entity.dart';
import 'package:kalm/presentation/cubit/curhat/curhat_cubit.dart';
import 'package:kalm/presentation/widgets/kalm_curhat_reply_tile.dart';
import 'package:kalm/presentation/widgets/kalm_detail_curhat_tile.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/kalm_switch_button.dart';
import 'package:kalm/presentation/widgets/kalm_text_field.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

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
  void initState() {
    context
        .read<CurhatCubit>()
        .getCurhatDetail(GetStorage().read('user_id'), widget.curhatId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _replyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurhatCubit, CurhatState>(
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
            style:
                kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
          ),
        ),
        body: BlocBuilder<CurhatCubit, CurhatState>(
          builder: (builderContext, state) {
            if (state is DetailCurhatLoaded)
              return Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          KalmDetailCurhatTile(
                            user: state.detailCurhatan.user ?? UserEntity(),
                            content: state.detailCurhatan.content ?? "",
                            topic: state.detailCurhatan.category ?? "-",
                            postedAt: state.detailCurhatan.createdAt,
                            likeCount: state.detailCurhatan.curhatLike ?? [],
                            isAnonymous: state.detailCurhatan.isAnonymous,
                          ),
                          const SizedBox(height: 15),
                          Row(
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
                          const SizedBox(height: 10),
                          Container(
                            height: state.detailCurhatan.comments!.isEmpty
                                ? 200
                                : 200,
                            child: RefreshIndicator(
                              onRefresh: () async {},
                              color: primaryColor,
                              child: state.detailCurhatan.comments!.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          state.detailCurhatan.comments!.length,
                                      itemBuilder: (_, index) {
                                        DetailCommentEntity komentar = state
                                            .detailCurhatan.comments![index];
                                        return KalmCurhatReplyTile(
                                          comment: komentar.content ?? '-',
                                          userName: komentar.username ?? '-',
                                          postedAt: komentar.createdAt,
                                          isAnonymous: komentar.isAnonymous,
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text('Belum ada komentar'),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    color: tertiaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: KalmTextField(
                                  kalmTextFieldController: _replyController,
                                  minLines: 1,
                                  keyboardType: TextInputType.multiline,
                                  hintText: 'Tulis komentar...',
                                  focusColor: primaryColor,
                                  primaryColor: accentColor,
                                  accentColor: secondaryText,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (_replyController.text.isNotEmpty &&
                                      _formKey.currentState!.validate()) {
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor.withAlpha(35)),
                                  child: Icon(
                                    Iconsax.send_2,
                                    size: 24,
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
      ),
    );
  }
}
