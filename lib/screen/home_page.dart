import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/providers/theme_data.dart';
import 'package:rick_and_morty/screen/Character/character_page.dart';
import 'package:rick_and_morty/screen/episode/episode_page.dart';
import 'package:rick_and_morty/screen/location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final pages = [
    CharacterPage(),
    location(),
    episodePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _NavigationBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Image.asset('assets/logo.png', height: 70),
        ),
        elevation: 2,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Provider.of<ThemeColorData>(context, listen: false)
                    .setLightMode();
              },
              icon: Icon(Provider.of<ThemeColorData>(context).isLightMode
                  ? Icons.light_mode
                  : Icons.mode_night))
        ],
      ),
      body: pages[pageIndex],
    );
  }

  NavigationBarTheme _NavigationBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.greenAccent,
        labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ),
      child: NavigationBar(
        backgroundColor: Colors.tealAccent,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 60,
        animationDuration: const Duration(seconds: 1),
        selectedIndex: pageIndex,
        onDestinationSelected: (pageIndex) =>
            setState(() => this.pageIndex = pageIndex),
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              selectedIcon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Home"),
          NavigationDestination(
              icon: Icon(
                Icons.language_outlined,
                size: 30,
              ),
              selectedIcon: Icon(
                Icons.language,
                size: 30,
              ),
              label: "Location"),
          NavigationDestination(
              icon: Icon(
                Icons.movie_creation_outlined,
                size: 30,
              ),
              selectedIcon: Icon(
                Icons.movie_creation_rounded,
                size: 30,
              ),
              label: "Episode"),
        ],
      ),
    );
  }
}
