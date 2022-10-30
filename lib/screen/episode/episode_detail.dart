import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_image.dart';
import 'package:rick_and_morty/constants/app_text.dart';
import 'package:rick_and_morty/constants/style.dart';
import 'package:rick_and_morty/model/episode_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class episodeDetail extends StatefulWidget {
  final int id;
  episodeDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<episodeDetail> createState() => _episodeDetailState();
}

class _episodeDetailState extends State<episodeDetail> {
  Episode l = Episode();

  bool loading = false;

  void getloc() async {
    Response res = await http
        .get(Uri.parse('https://rickandmortyapi.com/api/episode/${widget.id}'));
    var data = await jsonDecode(res.body);

    setState(() {
      l.name = data[0]['name'];
      l.air_date = data[0]['air_date'];
      l.episode = data[0]['episode'];
      l.id = data[0]['id'];
    });
  }

  @override
  void initState() {
    super.initState();
    getloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(appText.episode, style: googlefonts()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: 700,
                child: Image.asset(
                  app_images.fotoepisode,
                  fit: BoxFit.cover,
                ),
              ),
              Text(appText.yakinda,
                  textAlign: TextAlign.center, style: fontsyakinda()),
            ],
          ),
        ),
      ),
    );
  }
}
