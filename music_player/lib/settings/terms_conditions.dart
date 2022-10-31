import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:music_player/main.dart';

import '../Splash Screen/splashscreen.dart';
import '../constants/style.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: rootBundle.loadString('assets/terms_and_conditions.md'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Markdown(
                data: snapshot.data!,
                styleSheet: MarkdownStyleSheet.fromTheme(
                  ThemeData(
                      textTheme:  TextTheme(
                          bodyText2:
                              TextStyle(fontSize: 18,color:  isDarkMode ? whiteClr : blackClr),),),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
