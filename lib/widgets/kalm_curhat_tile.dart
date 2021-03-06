import 'package:flutter/material.dart';
import 'package:kalm/model/auth/user_model.dart';
import 'package:kalm/utilities/kalm_theme.dart';

import '../utilities/iconsax_icons.dart';

class KalmCurhatTile extends StatelessWidget {
  final Function()? onTap;
  final User userData;
  final String content;
  final DateTime? createdAt;
  final int? likeCount;
  final bool? isAnonymous;

  const KalmCurhatTile({
    Key? key,
    this.onTap,
    required this.userData,
    required this.content,
    this.createdAt,
    this.likeCount,
    this.isAnonymous,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.65,
      height: MediaQuery.of(context).size.height / 3,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.2,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: tertiaryColor.withOpacity(0.55),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.2,
              decoration: BoxDecoration(
                color: tertiaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isAnonymous == false ? userData.name! : 'Anonim',
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
                      ),
                      Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {},
                            child: Container(
                              width: 30,
                              height: 30,
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
                            '$likeCount',
                            style: kalmOfflineTheme.textTheme.subtitle1!
                                .apply(color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Container(
                    child: Flexible(
                      child: Text(
                        content,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style: kalmOfflineTheme.textTheme.subtitle2!
                            .apply(color: primaryText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
