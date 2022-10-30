import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import 'package:rick_and_morty/constants/app_color.dart';

import 'package:rick_and_morty/constants/style.dart';
import 'package:rick_and_morty/screen/episode/episode_detail.dart';

class Cardepsiode extends StatelessWidget {
  final String text;
  const Cardepsiode({
    Key? key,
    required this.widget,
    required this.text,
  }) : super(key: key);

  final episodeDetail widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GlassmorphicContainer(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.4,
          blur: 20,
          border: 2,
          borderRadius: 20,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                appColor.gradiant01,
                appColor.gradiant005,
              ],
              stops: [
                0.1,
                1,
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [appColor.gradiant05, appColor.gradiant05FF],
          ),
          child:
              Text(text, textAlign: TextAlign.center, style: googlefonts28())),
    );
  }
}
