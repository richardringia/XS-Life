import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/app/presentation/app_state.dart';
import 'package:xs_life/src/features/authentication/presentation/authentication_fab.dart';
import 'package:xs_life/src/features/authentication/presentation/profile_fab.dart';
import 'package:xs_life/src/features/forum/presentation/forum_fab.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("XS Life"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(GlobalConfiguration().get('lat').toString()),
          ],
        ),
      ),
      floatingActionButton: Consumer<AppState>(
        builder: (context, appState, _) => Wrap(
          direction: Axis.vertical,
          children: [
            AuthenticationFab(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
            ProfileFab(loggedIn: appState.loggedIn),
            const ForumFab(),
            Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: PageConstants.map,
                onPressed: () {
                  context.push('/${PageConstants.map}');
                },
                backgroundColor: Colors.orange,
                child: const Icon(Icons.map),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
