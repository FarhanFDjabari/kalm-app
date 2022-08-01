import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/meditation/meditation_cubit.dart';
import 'package:kalm/presentation/widgets/dummy_audio_list_header.dart';
import 'package:kalm/presentation/widgets/kalm_playlist_tile.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

import 'meditation_player.dart';

class MeditationAudioList extends StatefulWidget {
  final int playlistId;

  MeditationAudioList({this.playlistId = 3});

  @override
  _MeditationAudioListState createState() => _MeditationAudioListState();
}

class _MeditationAudioListState extends State<MeditationAudioList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<MeditationCubit>()
        .fetchPlaylistById(GetStorage().read('user_id'), widget.playlistId);
    return BlocListener<MeditationCubit, MeditationState>(
      listener: (context, state) {
        if (state is MeditationLoadError) {
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: primaryText,
            ),
          ),
          title: Text(
            'Playlist',
            style:
                kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              BlocBuilder<MeditationCubit, MeditationState>(
                builder: (builderContext, state) {
                  if (state is DetailPlaylistLoaded)
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 26),
                          child: CachedNetworkImage(
                            imageUrl: state.playlist.roundedImage!.url!,
                            imageBuilder: (_, image) {
                              return Image.network(
                                state.playlist.roundedImage!.url!,
                                scale: 1.8,
                              );
                            },
                            placeholder: (_, __) {
                              return CircularProgressIndicator(
                                color: primaryColor,
                              );
                            },
                          ),
                        ),
                        Container(
                          color: backgroundColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: backgroundColor,
                                width: double.infinity,
                                child: Text(
                                  state.playlist.name!,
                                  textAlign: TextAlign.center,
                                  style: kalmOfflineTheme.textTheme.headline3!
                                      .apply(color: primaryText),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                color: backgroundColor,
                                width: double.infinity,
                                child: Text(
                                  '${state.playlist.quantity} Seri',
                                  textAlign: TextAlign.center,
                                  style: kalmOfflineTheme.textTheme.subtitle1!
                                      .apply(
                                          color: primaryText.withOpacity(0.5)),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                height: 54,
                                color: backgroundColor,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Image.asset(
                                        'assets/picture/picture-quotation.png',
                                        scale: 2,
                                      ),
                                    ),
                                    Text(
                                      state.playlist.description!,
                                      style: kalmOfflineTheme
                                          .textTheme.subtitle1!
                                          .apply(
                                        fontStyle: FontStyle.italic,
                                        color: primaryText,
                                      ),
                                      textAlign: TextAlign.center,
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
                    return DummyAudioListHeader();
                },
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: backgroundColor,
                        child: Text(
                          'Playlist',
                          style: kalmOfflineTheme.textTheme.bodyText1!
                              .apply(color: primaryText, fontSizeFactor: 1.2),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: backgroundColor,
                          child: BlocBuilder<MeditationCubit, MeditationState>(
                            builder: (context, state) {
                              if (state is DetailPlaylistLoaded) {
                                final musicList =
                                    state.playlist.playlistMusicItems!;
                                return ListView.builder(
                                  itemCount: musicList.length,
                                  shrinkWrap: true,
                                  primary: true,
                                  padding: const EdgeInsets.only(top: 10),
                                  itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: KalmPlaylistTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MeditationPlayer(
                                              musicList: musicList,
                                              audioIndex: index,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Iconsax.play,
                                      tileColor: tertiaryColor,
                                      iconColor: primaryColor,
                                      iconBackgroundColor: tertiaryColor,
                                      title: musicList[index].name!,
                                      subtitle: musicList[index].duration!,
                                    ),
                                  ),
                                );
                              } else
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
