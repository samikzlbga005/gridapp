import 'package:flutter/material.dart';
import 'package:gridapp/constants/constants.dart';
import 'package:gridapp/screens/highligths_screen.dart';
import 'package:gridapp/screens/main_screen.dart';
import 'package:gridapp/screens/settings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../components/amplitude/amplitude.dart';
import '../provider/ad_settings_provider.dart';
import '../provider/cover_pack_provider.dart';

class CustomBottomNavigatonBar extends StatefulWidget {
  const CustomBottomNavigatonBar({super.key});

  @override
  State<CustomBottomNavigatonBar> createState() => _CustomBottomNavigatonBar();
}

class _CustomBottomNavigatonBar extends State<CustomBottomNavigatonBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    late List<Widget> screens = [
      MainScreen(),
      HighLigths(),
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        backgroundColor: backgroundColor,
        title: Text(
          "GRID PRO+",
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () async {
                    await AmplitudeConnection.settings_screen_opened();
                    bottomSheet(context);
                  },
                  child: Image.asset(
                    "assets/main_top_rigth_button.png",
                    scale: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              child: child,
              opacity: animation,
            );
          },
          child: screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        height: MediaQuery.of(context).size.height * 0.10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (_selectedIndex != 0) {
                      await AmplitudeConnection.main_screen_opened();
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 7),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          child: child,
                          opacity: animation,
                        );
                      },
                      child: Image.asset(
                        _selectedIndex == 0
                            ? 'assets/main_button_active.png'
                            : 'assets/main_button.png',
                        scale: 1.2,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Main",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    //await context.read<PacksProvider>().getPacks();
                    await AmplitudeConnection.highlights_screen_opened();
                    if (_selectedIndex != 1) {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 7),
                    child: Image.asset(
                      _selectedIndex == 1
                          ? 'assets/highligths_button_active.png'
                          : 'assets/highligths_button.png',
                      scale: 1.2,
                    ),
                  ),
                ),
                Text(
                  "Highlights",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
/*
BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 51, 49, 49),
        items: [
          
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 7),
              child: Image.asset(
                _selectedIndex == 0
                    ? 'assets/main_button_active.png'
                    : 'assets/main_button.png',
              ),
            ),
            label: "Main",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 7),
              child: Image.asset(
                _selectedIndex == 1
                    ? 'assets/highligths_button_active.png'
                    : 'assets/highligths_button.png',
              ),
            ),
            label: "Highlights",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),

*/


/*
int _selecTedIndex = 0;

    late List<Widget> screens = [
      MainScreen(),
      HighLigths(),
    ];
    return Scaffold(
      body: screens[_selecTedIndex],
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          color: Color.fromARGB(255, 51, 49, 49),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Image.asset(
                  'assets/main_button.png',
                  scale: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HighLigths()));
                },
                child: Image.asset(
                  'assets/highligths_button.png',
                  scale: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );

 */


