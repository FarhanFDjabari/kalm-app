import 'package:flutter/material.dart';
import 'package:kalm/presentation/widgets/kalm_search_field.dart';
import 'package:kalm/styles/kalm_theme.dart';

class MeditationSearchPage extends StatefulWidget {
  @override
  _MeditationSearchPageState createState() => _MeditationSearchPageState();
}

class _MeditationSearchPageState extends State<MeditationSearchPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: KalmSearchField(
                        searchController: searchController,
                        suffixOnPressed: () {
                          searchController.clear();
                        },
                        isAutofocus: true,
                        icon: Icons.clear,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          print(value);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
