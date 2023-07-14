import 'dart:async';

import 'package:at_save/view/screens/landing_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

ValueNotifier<int>  currentIndex = ValueNotifier(0);

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingController createState() => LandingController();
}

class LandingController extends State<LandingScreen> {
  // position of the page
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool isConnected = true;
  // var selectedIndex = 0;
  @override
  void initState() {
    _connectivity = Connectivity();
    _subscribeToConnectivityChanges();
    super.initState();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }
///subscription to watch the network availability
  void _subscribeToConnectivityChanges() {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = (result != ConnectivityResult.none);
      });
    });
  }

  @override
  Widget build(BuildContext context) => LandingView(this);
// handles the toggle of the navigation bar
  void onItemTapped(int index) {
    currentIndex.value = index;
  }
}
