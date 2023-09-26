import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tune_up/constants/colours.dart';
import 'package:tune_up/constants/navbarItems.dart';
import 'package:tune_up/constants/ourTextStyle.dart';
import 'package:tune_up/pages/favourite.dart';
import 'package:tune_up/pages/playlist.dart';
import 'package:tune_up/pages/settings.dart';
import 'package:tune_up/pages/tracks.dart';
import 'package:tune_up/pages/home.dart';
import 'package:tune_up/widgets/customDialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // requestPermission();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TuneUp',
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const PageController(),
    );
  }
}

class PageController extends StatefulWidget {
  const PageController({super.key});

  @override
  State<PageController> createState() => _PageControllerState();
}

class _PageControllerState extends State<PageController> with WidgetsBindingObserver {
  bool isDialogShown = false;

  @override
  void initState() {
    super.initState();
    requestPermission(context);
    WidgetsBinding.instance.addObserver(this);
  }

   @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
     
      await Future.delayed(Duration(seconds: 1));
      // App is resumed, check permissions again
      var status = await Permission.audio.status;
      if (status.isGranted) {
        // If permission is granted, pop the dialog
        if(isDialogShown){
          Navigator.of(context).pop();
        }
        
      }
    }
  }

  void requestPermission(BuildContext context) async {
    // Request the permission
    PermissionStatus status = await Permission.audio.request();

    // If permission is denied, show a dialog that they cannot dismiss until they accept the permission
    if (status.isDenied) {
      isDialogShown = true;
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible:
              false, // User cannot dismiss the dialog by tapping outside of it
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content: Text('You must accept the permission to continue.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Open Settings'),
                  onPressed: () async {
                    // Open the app settings
                    openAppSettings();
                  },
                ),
              ],
            );
          },
        ).then((_) => isDialogShown = false);
      }
    }
  }

  // void requestPermission() async {
  //   final androidInfo = await DeviceInfoPlugin().androidInfo;
  //   late Map<Permission, PermissionStatus> statuses;

  //   if (androidInfo.version.sdkInt <= 32) {
  //     statuses = await [Permission.storage].request();
  //   } else {
  //     statuses = await [Permission.audio].request();
  //   }

  //   var allAccepted = true;

  //   statuses.forEach((permission, status) {
  //     if (status != PermissionStatus.granted) {
  //       allAccepted = false;
  //     }
  //   });

  //   if (!allAccepted) {
  //     if (mounted) {
  //       Completer completer = Completer();
  //       showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return CustomDialog(
  //             completer: completer,
  //           );
  //         },
  //       );
  //       await completer.future;

  //     }
  //   }
  // }

  int _currentIndex = 0;
  final inactiveColor = whiteColour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColour,
        title: Text(
          "TuneUp",
          style: ourTextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        bottom: appBarTab(),
      ),
      body: buildBody(),
    );
  }

  PreferredSize appBarTab() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: BottomNavyBar(
          backgroundColor: backgroundColour,
          containerHeight: 60.0,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            navBarItemStyle(),
            navBarItemStyle(
                icon: const Icon(Icons.playlist_play_rounded),
                name: "Playlist"),
            navBarItemStyle(
                icon: const Icon(Icons.favorite), name: "Favourites"),
            navBarItemStyle(
                icon: const Icon(Icons.text_rotate_vertical_outlined),
                name: "Tracks"),
            navBarItemStyle(icon: const Icon(Icons.settings), name: "Settings"),
          ],
        ));
  }

  Widget buildBody() {
    switch (_currentIndex) {
      case 1:
        return const Playlist();
      case 2:
        return const Favourite();
      case 3:
        return const Tracks();
      case 4:
        return const Settings();
      case 0:
      default:
        return const Home();
    }
  }
}
