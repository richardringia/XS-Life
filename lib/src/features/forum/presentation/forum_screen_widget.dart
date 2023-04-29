import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class ForumScreenWidget extends StatelessWidget {
  const ForumScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(GlobalConfiguration().get('lat').toString()),
          ],
        ),
      ),
    );
  }
}
