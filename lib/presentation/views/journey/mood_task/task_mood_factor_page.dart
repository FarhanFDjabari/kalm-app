import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/presentation/widgets/mood_factor_tile.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/styles/kalm_theme.dart';

class TaskMoodFactorPage extends StatefulWidget {
  final double? moodPoint;

  TaskMoodFactorPage({this.moodPoint = 0});

  @override
  _TaskMoodFactorPageState createState() => _TaskMoodFactorPageState();
}

class _TaskMoodFactorPageState extends State<TaskMoodFactorPage> {
  List<Map<String, dynamic>> factorCategory = [
    {
      'factor': 'Tidur',
      'icon': Iconsax.moon,
      'selected_icon': Iconsax.moon5,
    },
    {
      'factor': 'Pekerjaan',
      'icon': Iconsax.briefcase,
      'selected_icon': Iconsax.briefcase5
    },
    {
      'factor': 'Hubungan',
      'icon': Iconsax.lovely,
      'selected_icon': Iconsax.lovely5
    },
    {
      'factor': 'Keluarga',
      'icon': Iconsax.home_2,
      'selected_icon': Iconsax.home_25
    },
    {
      'factor': 'Teman',
      'icon': Iconsax.profile_2user,
      'selected_icon': Iconsax.profile_2user5,
    },
    {
      'factor': 'Pendidikan',
      'icon': Iconsax.teacher,
      'selected_icon': Iconsax.teacher5
    },
    {
      'factor': 'Finansial',
      'icon': Iconsax.empty_wallet,
      'selected_icon': Iconsax.empty_wallet5
    },
    {
      'factor': 'Lainnya',
      'icon': Iconsax.bubble,
      'selected_icon': Iconsax.bubble5,
    },
  ];
  List<String> moodFactor = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoodTrackerCubit, MoodTrackerState>(
      listener: (context, state) {
        if (state is MoodTrackerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            KalmSnackbar(
              message: state.errorMessage,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is MoodTrackerSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            KalmSnackbar(
              message: 'Mood Tracker berhasil disimpan',
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: primaryText,
            ),
          ),
          title: Text(
            'MOOD TRACKER',
            style: kalmOfflineTheme.textTheme.headline1!.apply(
              color: primaryText,
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/picture/picture-background_bottom_middle.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Apa yang membuat harimu terasa buruk?',
                        style: kalmOfflineTheme.textTheme.headline1!
                            .apply(color: primaryText, fontSizeFactor: 1.1),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: factorCategory.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => MoodFactorTile(
                          label: factorCategory[index]['factor'],
                          selectedIcon: factorCategory[index]['selected_icon'],
                          icon: factorCategory[index]['icon'],
                          onTap: () {
                            if (moodFactor
                                .contains(factorCategory[index]['factor']))
                              moodFactor
                                  .remove(factorCategory[index]['factor']);
                            else
                              moodFactor.add(factorCategory[index]['factor']);
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
                      builder: (buildContext, state) {
                        return KalmButton(
                          width: double.infinity,
                          height: 56,
                          child: Text(
                            'Simpan Mood',
                            style: kalmOfflineTheme.textTheme.button!.apply(
                                color: tertiaryColor, fontSizeFactor: 1.2),
                          ),
                          primaryColor: primaryColor,
                          borderRadius: 10,
                          onPressed: () {
                            if (moodFactor.isNotEmpty)
                              buildContext
                                  .read<MoodTrackerCubit>()
                                  .postMoodTracker(
                                    GetStorage().read('user_id'),
                                    widget.moodPoint!.toInt(),
                                    moodFactor,
                                  );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
