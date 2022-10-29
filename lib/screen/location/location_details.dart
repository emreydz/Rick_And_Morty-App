import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/model/character_model.dart';
import 'package:rick_and_morty/model/location_model.dart';
import 'package:rick_and_morty/widgets/card_widget.dart';

class locationDetails extends StatefulWidget {
  final int id;
  final String name;
  final String type;
  final String dimension;

  locationDetails({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
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
        title: Text(
          "LOCATİONS",
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
                height: 250,
                width: 250,
                child: Image.asset(
                  "assets/locations.png",
                  fit: BoxFit.cover,
                ),
              ),
              Carddetail(widget: widget, text: "Name: ${widget.name}"),
              Carddetail(widget: widget, text: "Type: ${widget.type}"),
              Carddetail(
                  widget: widget, text: "Dimension: ${widget.dimension}"),
            ],
          ),
        ),
      ),
    );
  }
}
