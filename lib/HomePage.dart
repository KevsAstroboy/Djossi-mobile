import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItemIndex = 0;
  final screens = <Widget>[Home(),Scaffold()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedItemIndex],
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(const Icon(CupertinoIcons.home), 0),
          buildNavBarItem(const Icon(CupertinoIcons.person), 1),
          // buildNavBarItem(const Icon(CupertinoIcons.person), 1),
          // buildNavBarItem(const Icon(CupertinoIcons.person), 1),
        ],
      ),
    );
  }
  Widget buildNavBarItem(Icon icon, int index) {
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedItemIndex = index;
      });
    },
    child: Container(
      height: 60,

      width: MediaQuery.of(context).size.width/2,
      decoration: index == _selectedItemIndex
          ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 4, color: Color(0xff426CEA))),
              gradient: LinearGradient(
                colors: [
                  Color(0xff426CEA).withOpacity(0.3),
                  Color(0xff426CEA).withOpacity(0.015)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            )
          : BoxDecoration(),
      child: icon,
    ),
  );
}
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        // Contenu de votre page d'accueil
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/ould.jpg'),
          ),
          SizedBox(width: 10),
          Text('Hi, DIANA',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black)),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications,size: 30,color: Colors.black,),
          onPressed: () {
            // Action when notification icon is pressed
          },
        ),
      ],
    );
  }
}

