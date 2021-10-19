import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/cubit/journey/journey_cubit.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/views/journey/journey_detail_page.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_journey_image_card.dart';
import 'package:kalm/widgets/kalm_snackbar.dart';

class JourneyPage extends StatefulWidget {
  @override
  _JourneyPageState createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage>
    with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<JourneyCubit>(
      create: (context) =>
          JourneyCubit()..fetchAllJourney(GetStorage().read('user_id')),
      child: BlocListener<JourneyCubit, JourneyState>(
        listener: (listenerContext, state) {
          if (state is JourneyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: backgroundColor,
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
                BlocBuilder<JourneyCubit, JourneyState>(
                  builder: (builderContext, state) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        builderContext
                            .read<JourneyCubit>()
                            .fetchAllJourney(GetStorage().read('user_id'));
                      },
                      color: primaryColor,
                      child: ListView(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                            centerTitle: true,
                            elevation: 0,
                            leading: Icon(
                              Iconsax.menu_1,
                              color: primaryText,
                            ),
                            title: Text(
                              'JOURNEY',
                              style:
                                  kalmOfflineTheme.textTheme.headline1!.apply(
                                color: primaryText,
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: BlocBuilder<JourneyCubit, JourneyState>(
                              builder: (context, state) {
                                if (state is JourneyLoaded)
                                  return Swiper(
                                    scrollDirection: Axis.horizontal,
                                    itemHeight:
                                        MediaQuery.of(context).size.height *
                                            0.85,
                                    itemCount: state.journeyList.length,
                                    onIndexChanged: (index) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    viewportFraction: 0.85,
                                    scale: 0.65,
                                    loop: false,
                                    itemBuilder: (_, index) => Column(
                                      children: [
                                        KalmJourneyImageCard(
                                          imagePath: state
                                              .journeyList[index].image.url!,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 30),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: tertiaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    state.journeyList[index]
                                                        .title,
                                                    style: kalmOfflineTheme
                                                        .textTheme.button!
                                                        .apply(
                                                            color: primaryText,
                                                            fontSizeFactor:
                                                                1.1),
                                                  ),
                                                  if (state.journeyList[index]
                                                          .finishedProgress >
                                                      0)
                                                    Text(
                                                      'Progress '
                                                      '${state.journeyList[index].finishedProgress}'
                                                      '/${state.journeyList[index].totalProgress}',
                                                      style: kalmOfflineTheme
                                                          .textTheme.button!
                                                          .apply(
                                                              color:
                                                                  primaryColor),
                                                    ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                state.journeyList[index].author,
                                                style: kalmOfflineTheme
                                                    .textTheme.bodyText1!
                                                    .apply(
                                                        color: secondaryText),
                                              ),
                                              SizedBox(height: 12),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  state.journeyList[index]
                                                      .description2,
                                                  style: kalmOfflineTheme
                                                      .textTheme.subtitle1!
                                                      .apply(
                                                          color: primaryText,
                                                          fontSizeFactor: 1.1),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              KalmButton(
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.065,
                                                primaryColor: primaryColor,
                                                borderRadius: 10,
                                                child: Text(
                                                  state.journeyList[index]
                                                              .finishedProgress >
                                                          0
                                                      ? 'Lanjutkan Journey'
                                                      : 'Mulai Journey',
                                                  style: kalmOfflineTheme
                                                      .textTheme.bodyText1!
                                                      .apply(
                                                          color: tertiaryColor),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        JourneyDetailPage(
                                                      journeyId: state
                                                          .journeyList[index]
                                                          .id,
                                                    ),
                                                  ));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                else
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: primaryColor),
                                    ),
                                  );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
