import 'package:flutter/material.dart';
import 'package:kalm/model/auth/user_model.dart';
import 'package:kalm/model/curhat/detail_curhat_model.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/kalm_theme.dart';

import 'kalm_chip_button.dart';

class KalmDetailCurhatTile extends StatelessWidget {
  const KalmDetailCurhatTile({
    Key? key,
    required this.user,
    this.postedAt,
    required this.content,
    required this.topic,
    required this.likeCount,
    this.isAnonymous,
  }) : super(key: key);

  final User user;
  final DateTime? postedAt;
  final String content;
  final String topic;
  final List<CurhatLike> likeCount;
  final bool? isAnonymous;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        isAnonymous == false ? user.name! : 'Anonim',
                        style: kalmOfflineTheme.textTheme.button!
                            .apply(color: primaryText),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '1 hari yang lalu',
                        style: kalmOfflineTheme.textTheme.subtitle2!
                            .apply(color: secondaryText),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: primaryColor,
                        size: 28,
                      ),
                    ),
                  ),
                  Text(
                    '${likeCount.length}',
                    style: kalmOfflineTheme.textTheme.subtitle1!
                        .apply(color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 14),
          Expanded(
            child: Container(
              child: Text(
                content,
                style: kalmOfflineTheme.textTheme.subtitle2!
                    .apply(color: primaryText, fontSizeFactor: 1),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KalmChipButton(
                borderRadius: 40,
                width: 75,
                height: 26,
                activeColor: accentColor,
                color: primaryColor,
                text: '$topic',
                textSize: 12,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.menu_1,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
