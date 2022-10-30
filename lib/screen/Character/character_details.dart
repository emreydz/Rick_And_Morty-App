import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/model/character_model.dart';
import 'package:rick_and_morty/widgets/card_character.dart';

class CharacterDetails extends StatefulWidget {
  final int id;
  final String img;
  final String name;
  final String status;
  final String species;
  final String gender;
  CharacterDetails(
      {required this.id,
      required this.img,
      required this.status,
      required this.name,
      required this.species,
      required this.gender});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  Character c = Character();
  bool loading = false;

  void getChar() async {
    Response res = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/${widget.id}'));
    var data = await jsonDecode(res.body);

    setState(() {
      c.name = data[0]['name'];
      c.img = data[0]['img'];
      c.status = data[0]['status'];
      c.gender = data[0]['gender'];
      c.species = data[0]['species'];
    });
  }

  @override
  void initState() {
    super.initState();
    getChar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network('${widget.img}', fit: BoxFit.fill))),
              cardcharacter(
                widget: widget,
                text: widget.name,
              ),
              cardcharacter(
                widget: widget,
                text: widget.gender,
              ),
              cardcharacter(
                widget: widget,
                text: widget.species,
              ),
              cardcharacter(
                widget: widget,
                text: widget.status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
