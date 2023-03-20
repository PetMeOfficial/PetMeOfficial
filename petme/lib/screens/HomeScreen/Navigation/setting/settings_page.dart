import 'package:flutter/material.dart';
import 'package:petme/screens/HomeScreen/Navigation/setting/profile_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}