import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/constants/app_color.dart';
import 'package:rick_and_morty/constants/app_image.dart';
import 'package:rick_and_morty/constants/app_text.dart';
import 'package:rick_and_morty/constants/style.dart';
import 'package:rick_and_morty/model/character_model.dart';
import 'package:rick_and_morty/model/location_model.dart';
import 'package:rick_and_morty/widgets/card_location.dart';

class locationDetails extends StatefulWidget {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<Character> characters;

  locationDetails({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.characters,
  }) : super(key: key);

  @override
  State<locationDetails> createState() => _locationDetailsState();
}

class _locationDetailsState extends State<locationDetails> {
  Location l = Location();

  bool loading = false;

  void getloc() async {
    Response res = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/location/${widget.id}'));
    var data = await jsonDecode(res.body);

    setState(() {
      l.name = data[0]['name'];
      l.dimension = data[0]['dimension'];
      l.type = data[0]['type'];
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
        title: Text(appText.location, style: googlefonts()),
        backgroundColor: appColor.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image.asset(
                  app_images.fotolocation,
                  fit: BoxFit.cover,
                ),
              ),
              Cardlocation(
                  widget: widget, text: "${appText.Name}: ${widget.name}"),
              Cardlocation(
                  widget: widget, text: "${appText.Type}: ${widget.type}"),
              Cardlocation(
                  widget: widget,
                  text: "${appText.Dimension}: ${widget.dimension}"),
            ],
          ),
        ),
      ),
    );
  }
}
