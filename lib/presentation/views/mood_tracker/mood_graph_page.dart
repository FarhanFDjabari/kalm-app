import 'package:flutter/material.dart';
import 'package:kalm/presentation/views/mood_tracker/daily_mood_tab.dart';
import 'package:kalm/presentation/views/mood_tracker/weekly_mood_tab.dart';
import 'package:kalm/styles/kalm_theme.dart';

class MoodGraphPage extends StatefulWidget {
  @override
  State<MoodGraphPage> createState() => _MoodGraphPageState();
}

class _MoodGraphPageState extends State<MoodGraphPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryText,
          ),
        ),
        title: Text(
          'GRAFIK MOOD',
          style: kalmOfflineTheme.textTheme.headline1!.apply(
            color: primaryText,
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Text(
                'Harian',
                style: kalmOfflineTheme.textTheme.bodyText2!
                    .copyWith(fontWeight: FontWeight.bold, color: primaryText)
                    .apply(fontSizeFactor: 1.1),
              ),
            ),
            Tab(
              child: Text(
                'Mingguan',
                style: kalmOfflineTheme.textTheme.bodyText2!
                    .copyWith(fontWeight: FontWeight.bold, color: primaryText)
                    .apply(fontSizeFactor: 1.1),
              ),
            ),
          ],
          indicatorColor: primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 4,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          DailyMoodTab(),
          WeeklyMoodTab(),
        ],
      ),
    );
  }
}
