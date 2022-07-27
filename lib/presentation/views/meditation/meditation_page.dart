import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/meditation/meditation_cubit.dart';
import 'package:kalm/presentation/views/meditation/meditation_search_page.dart';
import 'package:kalm/presentation/widgets/kalm_icon_button.dart';
import 'package:kalm/presentation/widgets/kalm_meditation_tile.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/kalm_text_button.dart';
import 'package:kalm/presentation/widgets/meditation_header_tile.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class MeditationPage extends StatefulWidget {
  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = 0;

  List<Map<String, dynamic>> topicData = [
    {
      'topic': 'Semua',
      'icon': Iconsax.category5,
      'icon_selected': Iconsax.category5,
      'value': 0
    },
    {
      'topic': 'Relaksasi',
      'icon': Iconsax.coffee,
      'icon_selected': Iconsax.coffee5,
      'value': 1
    },
    {
      'topic': 'Tidur',
      'icon': Iconsax.book,
      'icon_selected': Iconsax.book5,
      'value': 2
    },
    {
      'topic': 'Hubungan',
      'icon': Iconsax.lovely,
      'icon_selected': Iconsax.lovely5,
      'value': 3
    },
    {
      'topic': 'Produktif',
      'icon': Iconsax.moon,
      'icon_selected': Iconsax.moon5,
      'value': 4
    },
    {
      'topic': 'Kecemasan',
      'icon': Iconsax.emoji_sad,
      'icon_selected': Iconsax.emoji_sad5,
      'value': 1
    },
    {
      'topic': 'Kesehatan',
      'icon': Iconsax.user,
      'icon_selected': Iconsax.user5,
      'value': 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<MeditationCubit>(
      create: (context) =>
          MeditationCubit()..fetchAllPlaylist(GetStorage().read('user_id')),
      child: BlocListener<MeditationCubit, MeditationState>(
        listener: (context, state) {
          if (state is MeditationLoadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is MeditationPlaylistLoaded) {
            if (state.playlistList.isEmpty) {
              context
                  .read<MeditationCubit>()
                  .fetchAllPlaylist(GetStorage().read('user_id'));
            }
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
            automaticallyImplyLeading: false,
            title: Text(
              'MEDITASI',
              style: kalmOfflineTheme.textTheme.headline1!.apply(
                color: primaryText,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MeditationSearchPage(),
                    ),
                  );
                },
                icon: Icon(
                  Iconsax.search_normal,
                  color: primaryText,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.archive_1,
                  color: primaryText,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              BlocBuilder<MeditationCubit, MeditationState>(
                builder: (context, state) {
                  if (state is MeditationPlaylistLoaded)
                    return MeditationHeaderTile(
                      musicList: state.playlistList[0].playlistMusicItems,
                    );
                  else
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Topik Musik Meditasi',
                      style: kalmOfflineTheme.textTheme.bodyText1!
                          .apply(color: primaryText, fontSizeFactor: 1.1),
                    ),
                    KalmTextButton(
                      width: 130,
                      height: 20,
                      primaryColor: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Lihat Semua',
                            style: kalmOfflineTheme.textTheme.bodyText1!
                                .apply(color: primaryText, fontSizeFactor: 1),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: primaryText,
                            size: 18,
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
                child: BlocBuilder<MeditationCubit, MeditationState>(
                  builder: (builderContext, state) {
                    return ListView.builder(
                      itemCount: topicData.length,
                      itemExtent: 100,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => KalmIconButton(
                        itemIndex: index,
                        selectedIndex: selectedIndex,
                        width: 100,
                        height: 100,
                        iconRadius: 65,
                        iconSize: 24,
                        fontSize: 14,
                        label: topicData[index]['topic'],
                        icon: topicData[index]['icon'],
                        iconSelected: topicData[index]['icon_selected'],
                        primaryColor: primaryColor,
                        onTap: () {
                          if (selectedIndex != index && index > 0)
                            builderContext
                                .read<MeditationCubit>()
                                .fetchPlaylistByCategory(
                                  GetStorage().read('user_id'),
                                  topicData[index]['topic'],
                                );
                          else if (selectedIndex != index && index == 0)
                            builderContext
                                .read<MeditationCubit>()
                                .fetchAllPlaylist(GetStorage().read('user_id'));
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<MeditationCubit, MeditationState>(
                  builder: (builderContext, state) {
                    if (state is MeditationPlaylistLoaded) {
                      final playlistList = state.playlistList;
                      return RefreshIndicator(
                        onRefresh: () async {
                          builderContext
                              .read<MeditationCubit>()
                              .fetchAllPlaylist(GetStorage().read('user_id'));
                        },
                        color: primaryColor,
                        child: ListView.builder(
                          itemCount: playlistList.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (_, index) => KalmMeditationTile(
                            playlistId: playlistList[index].id!,
                            imagePath: playlistList[index].squaredImage!.url!,
                            series: playlistList[index].quantity!,
                            description: playlistList[index].description!,
                            title: playlistList[index].name!,
                          ),
                        ),
                      );
                    } else
                      return Container(
                        child: Center(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              builderContext
                                  .read<MeditationCubit>()
                                  .fetchAllPlaylist(
                                      GetStorage().read('user_id'));
                            },
                            color: primaryColor,
                            child: ListView(
                              padding: const EdgeInsets.all(20),
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
