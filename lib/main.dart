import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GNav Example',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    PageContent(
      icon: LineIcons.home,
      title: 'Welcome Home!',
      color: Colors.deepPurpleAccent,
    ),
    PageContent(
      icon: LineIcons.heartAlt,
      title: 'Your Favorites',
      color: Colors.pinkAccent,
    ),
    PageContent(
      icon: LineIcons.search,
      title: 'Search Anything',
      color: Colors.teal,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PageContent(
          icon: LineIcons.user,
          title: 'Your Profile',
          color: Colors.orangeAccent,
        ),
        SizedBox(height: 20),
        OpenWebAppLink(), // 👈 this adds your button
      ],
    ),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GNav Bar Demo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 10,
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _widgetOptions[_selectedIndex],
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: GNav(
              backgroundColor: Colors.transparent,
              rippleColor: Colors.white.withOpacity(0.1),
              hoverColor: Colors.white.withOpacity(0.1),
              gap: 8,
              activeColor: Colors.white,
              iconSize: 26,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.white.withOpacity(0.2),
              color: Colors.white,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const PageContent({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      key: ValueKey<String>(title),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 90, color: color),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}



class OpenWebAppLink extends StatelessWidget {
  final String webAppUrl = "https://appho.st/d/stunzu22";

  Future<void> _openWebApp() async {
    final Uri uri = Uri.parse(webAppUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // opens in browser
      );
    } else {
      throw "Could not launch $webAppUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _openWebApp,
      child: Text("Open Web App"),
    );
  }
}
