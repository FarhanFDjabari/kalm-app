import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmJourneyImageCard extends StatelessWidget {
  const KalmJourneyImageCard({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        placeholder: (_, value) {
          return CircularProgressIndicator(
            color: primaryColor,
          );
        },
        imageBuilder: (_, __) => Image.network(
          imagePath,
          scale: 1.5,
        ),
        errorWidget: (_, value, __) {
          return Image.asset(
            'assets/picture/picture-journey_3.png',
            scale: 1.5,
          );
        },
      ),
    );
  }
}
