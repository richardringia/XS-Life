// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InstructionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions'),
      ),
      body: Center(
        child: Text(
          'Add your instructions here!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
