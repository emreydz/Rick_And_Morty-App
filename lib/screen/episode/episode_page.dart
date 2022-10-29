import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rick_and_morty/model/episode_model.dart';
import 'package:rick_and_morty/screen/episode/episode_detail.dart';

class episodePage extends StatefulWidget {
  episodePage({Key? key}) : super(key: key);

  @override
  State<episodePage> createState() => _episodePageState();
}

class _episodePageState extends State<episodePage> {
  List<Episode> episode = <Episode>[];
  ScrollController _scrollController = ScrollController();
  int pageNumber = 1;
  bool loading = false;

  void getepisode() async {
    Response response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/episode?page=$pageNumber'));

    Map<String, dynamic> map = await jsonDecode(response.body);
    List<dynamic> data = map['results'];
    print(data);

    setState(() {
      pageNumber++;
      for (var i = 0; i < data.length; i++) {
        Episode loc = Episode();
        loc.id = data[i]['id'];
        loc.name = data[i]['name'];
        loc.air_date = data[i]['air_date'];
        loc.episode = data[i]['episode'];

        loading = true;
        episode.add(loc);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getepisode();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        print('new data call');
        getepisode();
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
            child: SpinKitChasingDots(
              color: Colors.green.shade600,
            ),
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
                  itemCount: episode.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      margin: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        height: 100,
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => episodeDetail(
                                            id: episode[index].id!,
                                            episode: episode[index].episode!,
                                            air_date: episode[index].air_date!,
                                            name: episode[index].name!,
                                          )));
                            },
                            leading: Text(
                              "${episode[index].episode!}",
                              style: TextStyle(
                                  color: Colors.tealAccent,
                                  fontFamily: 'RickandMorty',
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            title: Text(
                              "${episode[index].name!}",
                              style: TextStyle(
                                  fontFamily: 'RickandMorty',
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "${episode[index].air_date!}",
                              style: TextStyle(
                                  fontFamily: 'RickandMorty',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
