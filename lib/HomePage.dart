import 'dart:convert';

import 'package:djossi_mobile_app/Authentication.dart';
import 'package:djossi_mobile_app/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'constants.dart';
import 'main_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List allServicelist;
  bool isLoading = false;

  Future<void> getAllDemandesServices() async {
    try {
      final response =
          await get(Uri.parse("${AppUrl.getReservation}/${prestataire.id}"));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final responsePrestataire = responseData['data'];
        debugPrint("La requete a reussis, voici le contenu : $responseData");
      } else {
        var responseData = json.decode(response.body);
        debugPrint("La requete a echoue, voici le contenu : $responseData");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['data']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  int _selectedItemIndex = 0;
  final screens = <Widget>[const MainScreen(), const AccountScren()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedItemIndex],
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(const Icon(CupertinoIcons.home), 0),
          buildNavBarItem(const Icon(CupertinoIcons.person), 1),
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
        width: MediaQuery.of(context).size.width / 2,
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
            : const BoxDecoration(),
        child: icon,
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
            backgroundImage: NetworkImage(
                "${AppUrl.onlineSimpleUrl}/${prestataire.profileUrl}"),
          ),
          SizedBox(width: 10),
          Text("Bienvenue, ${prestataire.prenom}",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black)),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            // Action when notification icon is pressed
          },
        ),
      ],
    );
  }
}
