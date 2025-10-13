import 'package:flutter/material.dart';

class La extends StatefulWidget {
  const La({super.key});

  @override
  State<La> createState() => _LaState();
}

class _LaState extends State<La> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:Padding(
  padding: const EdgeInsets.all(8.0),
  child: Title(color: Colors.red, title: 'laith', child: AppBar()),
) ,






    );
  }
}
