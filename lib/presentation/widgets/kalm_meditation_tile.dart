import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kalm/presentation/views/meditation/meditation_audio_list.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmMeditationTile extends StatelessWidget {
  const KalmMeditationTile({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.series,
    required this.playlistId,
  }) : super(key: key);

  final String imagePath;
  final int playlistId;
  final String title;
  final String description;
  final String series;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      child: Stack(
        children: [
          Positioned(
            bottom: 5,
            left: 1,
            right: 1,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.14,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: tertiaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MeditationAudioList(
                  playlistId: playlistId,
                ),
              ));
            },
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.16,
              decoration: BoxDecoration(
                color: tertiaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: kalmOfflineTheme.textTheme.bodyText1!.apply(
                              color: primaryText,
                              fontSizeFactor: 1.2,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              '$series Seri Audio',
                              softWrap: true,
                              style: kalmOfflineTheme.textTheme.subtitle1!
                                  .apply(
                                      color: secondaryText, fontSizeFactor: 1),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              description,
                              softWrap: true,
                              style: kalmOfflineTheme.textTheme.subtitle1!
                                  .apply(fontSizeFactor: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: imagePath,
                      placeholder: (_, value) {
                        return CircularProgressIndicator();
                      },
                      errorWidget: (_, value, __) {
                        return Image.asset(
                          'assets/picture/picture-rekomendasi_meditasi_1.png',
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
