import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduction'),
      ),
      body: Column(
        children: [
          const Text(
            'Add your instructions here!',
            style: TextStyle(fontSize: 24.0),
          ),
          FilledButton(onPressed: () {
            context.replace('/${PageConstants.map}');
          }, child: const Text("Button"))
        ],
      )
    );
  }
}
