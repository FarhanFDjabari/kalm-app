import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/meditation/meditation_search_page.dart';
import 'package:kalm/widgets/kalm_icon_button.dart';
import 'package:kalm/widgets/kalm_meditation_tile.dart';
import 'package:kalm/widgets/kalm_search_field.dart';
import 'package:kalm/widgets/kalm_text_button.dart';
import 'package:kalm/widgets/meditation_header_tile.dart';

class MeditationPage extends StatefulWidget {
  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isSearching = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: isSearching
            ? null
            : IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.menu,
                  color: primaryText,
                ),
              ),
        automaticallyImplyLeading: false,
        title: isSearching
            ? KalmSearchField(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MeditationSearchPage(),
                  ),
                ),
                suffixOnPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                readOnly: true,
              )
            : Text(
                'MEDITASI',
                style: kalmOfflineTheme.textTheme.headline1!.apply(
                  color: primaryText,
                ),
              ),
        actions: [
          if (!isSearching)
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: Icon(
                Iconsax.search_normal,
                color: primaryText,
              ),
            ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.archive,
              color: primaryText,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          MeditationHeaderTile(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Topik Musik Meditasi',
                  style: kalmOfflineTheme.textTheme.bodyText1!
                      .apply(color: primaryText, fontSizeFactor: 1.2),
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
                            .apply(color: primaryText, fontSizeFactor: 1.2),
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
            child: ListView.builder(
              itemCount: 6,
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
                label: 'Relaksasi',
                icon: Icons.book_outlined,
                iconSelected: Icons.book,
                primaryColor: primaryColor,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              color: primaryColor,
              child: ListView.builder(
                itemCount: 3,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (_, index) => KalmMeditationTile(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
