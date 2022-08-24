import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalm/data/model/auth/user_model.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmCurhatTile extends StatelessWidget {
  final Function()? onTap;
  final UserEntity userData;
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

  getFormattedDate(DateTime? date) {
    return DateFormat('d MMMM y').format(date ?? DateTime.now());
  }

  int calculateDifference(DateTime? date) {
    DateTime now = DateTime.now();
    return DateTime(date?.year ?? now.year, date?.month ?? now.month,
            date?.day ?? now.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  String getTimestamp(int timeDifference, DateTime? date) {
    if (timeDifference < 0) {
      if (timeDifference > -1)
        return '${timeDifference * -1} hari yang lalu';
      else
        return getFormattedDate(date);
    } else {
      return 'Hari ini';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3.2,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(45),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isAnonymous == false ? userData.name! : 'Anonim',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kalmOfflineTheme.textTheme.button!
                              .apply(color: primaryText),
                        ),
                        SizedBox(height: 4),
                        Text(
                          getTimestamp(
                              calculateDifference(createdAt), createdAt),
                          style: kalmOfflineTheme.textTheme.subtitle2!
                              .apply(color: secondaryText, fontSizeFactor: 0.9),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            color: primaryColor,
                            size: 22,
                          ),
                          Text(
                            '$likeCount',
                            style: kalmOfflineTheme.textTheme.subtitle1!.apply(
                                color: primaryColor, fontSizeFactor: 0.9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Container(
                child: Flexible(
                  child: Text(
                    content,
                    maxLines: 6,
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
    );
  }
}
