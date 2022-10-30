import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rick_and_morty/constants/app_color.dart';
import 'package:rick_and_morty/constants/app_image.dart';

import 'package:rick_and_morty/constants/style.dart';
import 'package:rick_and_morty/model/character_model.dart';
import 'package:rick_and_morty/model/location_model.dart';
import 'package:rick_and_morty/screen/location/location_details.dart';

class location extends StatefulWidget {
  location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  List<Character> characters = <Character>[];
  List<Location> location = <Location>[];
  ScrollController _scrollController = ScrollController();
  int pageNumber = 1;
  bool loading = false;

  void getlocation() async {
    Response response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/location?page=$pageNumber'));

    Map<String, dynamic> map = await jsonDecode(response.body);
    List<dynamic> data = map['results'];
    print(data);

    setState(() {
      pageNumber++;
      for (var i = 0; i < data.length; i++) {
        Location loc = Location();
        loc.id = data[i]['id'];
        loc.name = data[i]['name'];
        loc.type = data[i]['type'];
        loc.dimension = data[i]['dimension'];

        loading = true;
        location.add(loc);
      }
    });
  }

  void getCharacters() async {
    Response response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character?page=$pageNumber'));

    Map<String, dynamic> map = await jsonDecode(response.body);
    List<dynamic> data = map['results'];
    print(data);

    setState(() {
      pageNumber++;
      for (var i = 0; i < data.length; i++) {
        Character char = Character();
        char.id = data[i]['id'];
        char.name = data[i]['name'];
        char.img = data[i]['image'];
        char.status = data[i]['status'];
        char.gender = data[i]['gender'];
        char.species = data[i]['species'];
        loading = true;
        characters.add(char);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
    getlocation();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        print('new data call');
        getlocation();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Center(
            child: SpinKitChasingDots(color: appColor.green600),
          )
        : Scaffold(
            body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).backgroundColor,
                Theme.of(context).scaffoldBackgroundColor
              ],
              tileMode: TileMode.mirror,
            )),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: location.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      margin: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(20.0)),
                        height: 100,
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => locationDetails(
                                            characters: [],
                                            id: location[index].id!,
                                            type: location[index].type!,
                                            dimension:
                                                location[index].dimension!,
                                            name: location[index].name!,
                                          )));
                            },
                            leading: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(app_images.character),
                            ),
                            title: Text(
                              "${location[index].name!}",
                              style: textstyle26(),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_sharp),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ));
  }
}
