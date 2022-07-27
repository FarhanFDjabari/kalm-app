import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/curhat/curhat_cubit.dart';
import 'package:kalm/presentation/views/curhat/curhat_detail_page.dart';
import 'package:kalm/presentation/views/curhat/post_curhat_page.dart';
import 'package:kalm/presentation/widgets/kalm_chip_button.dart';
import 'package:kalm/presentation/widgets/kalm_curhat_tile.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/kalm_text_button.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/iconsax_icons.dart';

class CurhatHome extends StatefulWidget {
  @override
  _CurhatHomeState createState() => _CurhatHomeState();
}

class _CurhatHomeState extends State<CurhatHome>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int _selectedIndex = 0;

  List<Map<String, dynamic>> curhatCategory = [
    {
      "category": "Terbaru",
      "value": 0,
    },
    {
      "category": "Pekerjaan",
      "value": 1,
    },
    {
      "category": "Hubungan",
      "value": 2,
    },
    {
      "category": "Keluarga",
      "value": 3,
    },
    {
      "category": "Teman",
      "value": 4,
    },
    {
      "category": "Pendidikan",
      "value": 5,
    },
    {
      "category": "Finansial",
      "value": 6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<CurhatCubit>(
      create: (context) =>
          CurhatCubit()..fetchAllCurhat(GetStorage().read('user_id')),
      child: BlocListener<CurhatCubit, CurhatState>(
        listener: (context, state) {
          if (state is CurhatLoadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: Icon(
              Iconsax.menu_1,
              color: primaryText,
            ),
            title: Text(
              'CURHAT',
              style: kalmOfflineTheme.textTheme.headline1!
                  .apply(color: primaryText),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/picture/picture-background_bottom_middle.png',
                      scale: 1.5,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 30,
                        child: BlocBuilder<CurhatCubit, CurhatState>(
                          builder: (builderContext, state) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: curhatCategory.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: KalmChipButton(
                                    borderRadius: 40,
                                    width: 75,
                                    height: 26,
                                    activeColor: primaryColor,
                                    color: accentColor,
                                    text: curhatCategory[index]['category'],
                                    textSize: 12,
                                    staticMode: false,
                                    currentIndex: _selectedIndex,
                                    itemIndex: index,
                                    onTap: () {
                                      if (index != 0)
                                        builderContext
                                            .read<CurhatCubit>()
                                            .fetchCurhatByCategory(
                                                GetStorage().read('user_id'),
                                                curhatCategory[index]
                                                    ['category']);
                                      else
                                        builderContext
                                            .read<CurhatCubit>()
                                            .fetchAllCurhat(
                                                GetStorage().read('user_id'));
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Terbaru',
                                style: kalmOfflineTheme.textTheme.bodyText1!
                                    .apply(
                                        color: primaryText,
                                        fontSizeFactor: 1.1),
                              ),
                            ),
                            KalmTextButton(
                              width: 120,
                              height: 20,
                              primaryColor: primaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Lihat Semua',
                                    style: kalmOfflineTheme.textTheme.bodyText1!
                                        .apply(
                                            color: primaryText,
                                            fontSizeFactor: 1),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: primaryText,
                                    size: 16,
                                  )
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CurhatCubit, CurhatState>(
                        builder: (builderContext, state) {
                          if (state is CurhatLoaded)
                            return Container(
                              width: double.infinity,
                              height: 252,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.curhatanList.length,
                                itemBuilder: (_, index) {
                                  return KalmCurhatTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CurhatDetailPage(
                                            curhatId:
                                                state.curhatanList[index].id!,
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        builderContext
                                            .read<CurhatCubit>()
                                            .fetchAllCurhat(
                                                GetStorage().read('user_id'));
                                      });
                                    },
                                    content: state.curhatanList[index].content!,
                                    createdAt:
                                        state.curhatanList[index].createdAt!,
                                    userData: state.curhatanList[index].user!,
                                    likeCount:
                                        state.curhatanList[index].likeCount!,
                                    isAnonymous:
                                        state.curhatanList[index].isAnonymous,
                                  );
                                },
                              ),
                            );
                          else
                            return Container(
                              width: double.infinity,
                              height: 252,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ),
                            );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '${curhatCategory[_selectedIndex]['category']}',
                                style: kalmOfflineTheme.textTheme.bodyText1!
                                    .apply(
                                        color: primaryText,
                                        fontSizeFactor: 1.1),
                              ),
                            ),
                            KalmTextButton(
                              width: 120,
                              height: 20,
                              primaryColor: primaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Lihat Semua',
                                    style: kalmOfflineTheme.textTheme.bodyText1!
                                        .apply(
                                            color: primaryText,
                                            fontSizeFactor: 1),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: primaryText,
                                    size: 16,
                                  )
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CurhatCubit, CurhatState>(
                        builder: (context, state) {
                          if (state is CurhatLoaded)
                            return Container(
                              width: double.infinity,
                              height: 252,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.curhatanList.length,
                                itemBuilder: (_, index) {
                                  return KalmCurhatTile(
                                    onTap: () {},
                                    content: state.curhatanList[index].content!,
                                    createdAt:
                                        state.curhatanList[index].createdAt!,
                                    userData: state.curhatanList[index].user!,
                                    likeCount:
                                        state.curhatanList[index].likeCount!,
                                    isAnonymous:
                                        state.curhatanList[index].isAnonymous,
                                  );
                                },
                              ),
                            );
                          else
                            return Container(
                              width: double.infinity,
                              height: 252,
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
                ],
              ),
            ),
          ),
          floatingActionButton: BlocBuilder<CurhatCubit, CurhatState>(
            builder: (builderContext, state) {
              return FloatingActionButton(
                backgroundColor: primaryColor,
                tooltip: 'Post Curhatan Baru',
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => PostCurhatPage(
                        userId: GetStorage().read('user_id'),
                      ),
                    ),
                  )
                      .then((value) {
                    builderContext
                        .read<CurhatCubit>()
                        .fetchAllCurhat(GetStorage().read('user_id'));
                  });
                },
                child: Icon(
                  Icons.add,
                  color: tertiaryColor,
                  size: 24,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
