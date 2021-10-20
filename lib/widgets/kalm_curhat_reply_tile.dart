import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

import '../utilities/iconsax_icons.dart';

class KalmCurhatReplyTile extends StatelessWidget {
  const KalmCurhatReplyTile({
    Key? key,
    required this.userName,
    this.postedAt,
    required this.comment,
    this.isAnonymous,
  }) : super(key: key);

  final String userName;
  final DateTime? postedAt;
  final String comment;
  final bool? isAnonymous;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                child: Icon(
                  Iconsax.user,
                  color: tertiaryColor,
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAnonymous == false ? userName : 'Komentar Anonim',
                    style: kalmOfflineTheme.textTheme.button!
                        .apply(color: primaryText),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '5 jam yang lalu',
                    style: kalmOfflineTheme.textTheme.subtitle2!
                        .apply(color: secondaryText),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 14),
          Container(
            child: Text(
              comment,
              style: kalmOfflineTheme.textTheme.subtitle2!
                  .apply(color: primaryText, fontSizeFactor: 1),
            ),
          ),
        ],
      ),
    );
  }
}
