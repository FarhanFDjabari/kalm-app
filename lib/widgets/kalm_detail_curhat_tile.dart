import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';

import 'kalm_chip_button.dart';

class KalmDetailCurhatTile extends StatelessWidget {
  const KalmDetailCurhatTile({
    Key? key,
  }) : super(key: key);

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
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Maria',
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
                    '123',
                    style: kalmOfflineTheme.textTheme.subtitle1!
                        .apply(color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 14),
          Container(
            child: Text(
              'Halo, temen temen aku sekarang sering belanja online karena kebanyakan racun dari tiktok sama ig. Gimana ya cara ngatasin biar aku ngga sekonsumtif itu :( ??? sebenernya kebutuhanku yang lain masih banyak, tp sungguh tidak terbendung',
              style: kalmOfflineTheme.textTheme.subtitle2!
                  .apply(color: primaryText, fontSizeFactor: 1),
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 26,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (_, index) => Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: KalmChipButton(
                      borderRadius: 40,
                      width: 55,
                      height: 26,
                      activeColor: accentColor,
                      color: primaryColor,
                      text: 'Uang',
                      textSize: 12,
                    ),
                  ),
                ),
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
