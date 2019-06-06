import 'dart:math';

import 'package:cybersport/app_screen_widgets/presentation/preference_icondart_icons.dart';
import 'package:cybersport/ui/browse.dart';
import 'package:cybersport/ui/home.dart';
import 'package:cybersport/ui/login.dart';
import 'package:cybersport/ui/organizer_dashboard.dart';
import 'package:cybersport/ui/preferences.dart';
import 'package:cybersport/ui/profile.dart';
import 'package:cybersport/app_screen_widgets/fab_bottom_app_bar.dart';
import 'package:cybersport/app_screen_widgets/fab_with_icons.dart';
import 'package:cybersport/app_screen_widgets/layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _lastSelected = 0;

  void _selectedTab(int index) {
    setState(() {
      if (index != _lastSelected) _lastSelected = index;
    });
  }

  Widget _selectedPage(int index) {
    switch (index) {
      case 0:
        {
          return Home();
        }
        break;
      case 1:
        {
          return OrgDash();
        }
        break;

      case 2:
        {
          return Pref();
        }
        break;
      case 3:
        {
          return Profile();
        }
        break;
      default:
        {
          return Home();
        }
    }
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blue,
      ),*/
      body: Center(child: _selectedPage(_lastSelected)),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: '',
        color: Colors.grey,
        selectedColor: Colors.deepOrangeAccent,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(
              iconData: Icons.collections_bookmark, text: 'Organize'),
          FABBottomAppBarItem(
              iconData: PreferenceIcondart.settings, text: 'Preference'),
          FABBottomAppBarItem(iconData: Icons.person_pin, text: 'Profile'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
    );
  }

  /*void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return FloatingActionButton(
      onPressed: () {
        debugPrint("FAB");
      },
      tooltip: 'Increment',
      child: Icon(Icons.explore),
      elevation: 2.0,
    );

    /* <=======FABWithIcon========>
    
    AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
    
    
    <=============================> */
  }
}

/*bottomNavigationBar: BottomNavigationBar(
items: <BottomNavigationBarItem>[
BottomNavigationBarItem(
icon: Icon(Icons.home), title: Text('Home')),
BottomNavigationBarItem(
icon: Icon(Icons.supervisor_account), title: Text('Organize')),
BottomNavigationBarItem(
icon: Icon(Icons.school), title: Text('Profile')),
],
currentIndex: _selectedIndex,
fixedColor: Colors.deepPurple,
onTap: _onItemTapped,
)*/
