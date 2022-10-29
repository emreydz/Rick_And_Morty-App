import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/model/episode_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class episodeDetail extends StatefulWidget {
  final int id;
  final String name;
  final String episode;
  final String air_date;
  episodeDetail(
      {Key? key,
      required this.id,
      required this.name,
      required this.episode,
      required this.air_date})
      : super(key: key);

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
        title: Text(
          "Episode",
          style: GoogleFonts.shadowsIntoLight(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              shadows: [
                const Shadow(
                  blurRadius: 3,
                )
              ]),
        ),
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
                  "assets/rickk.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Text("Çok Yakında",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.shadowsIntoLight(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
