import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kalm/cubit/journey/journey_cubit.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_snackbar.dart';

class JourneyCompletePage extends StatelessWidget {
  final int journeyId;
  final String imagePath;

  JourneyCompletePage({required this.journeyId, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JourneyCubit>(
      create: (context) => JourneyCubit()
        ..getJourneyQuote(
          GetStorage().read('user_id'),
          journeyId,
        ),
      child: BlocListener<JourneyCubit, JourneyState>(
        listener: (context, state) {
          if (state is JourneyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'JOURNEY SELESAI',
              style: kalmOfflineTheme.textTheme.headline1!
                  .apply(color: primaryText),
            ),
          ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<JourneyCubit, JourneyState>(
                  builder: (context, state) {
                    if (state is JourneyQuoteLoadSuccess) {
                      return Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: imagePath,
                              imageBuilder: (_, __) {
                                return Image.network(
                                  imagePath,
                                  scale: 2.3,
                                );
                              },
                              placeholder: (_, __) {
                                return CircularProgressIndicator(
                                  color: primaryColor,
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 22),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              '${state.quoteData.title}',
                              textAlign: TextAlign.center,
                              style: kalmOfflineTheme.textTheme.headline5!
                                  .apply(color: primaryText),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Text(
                              '“${state.quoteData.content}”',
                              textAlign: TextAlign.center,
                              style: kalmOfflineTheme.textTheme.subtitle2!
                                  .apply(
                                      color: primaryText,
                                      fontStyle: FontStyle.italic),
                            ),
                          ),
                          Container(
                            child: Text(
                              '${state.quoteData.author}',
                              textAlign: TextAlign.center,
                              style: kalmOfflineTheme.textTheme.bodyText2!
                                  .apply(color: primaryText),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          KalmButton(
                            width: double.infinity,
                            height: 56,
                            borderRadius: 10,
                            primaryColor: primaryColor,
                            child: Text(
                              'Kembali',
                              style: kalmOfflineTheme.textTheme.button!
                                  .apply(color: tertiaryColor),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
