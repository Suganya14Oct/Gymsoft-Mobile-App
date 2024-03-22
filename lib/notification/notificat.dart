import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Notificat extends StatefulWidget {
  const Notificat({super.key});

  @override
  State<Notificat> createState() => _NotificatState();
}

class _NotificatState extends State<Notificat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Center(child: Text("Coming Soon...")),
    );
  }
}
