import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/app/presentation/app_state.dart';
import 'package:xs_life/src/features/example_map_screen/presentation/example_map_widget.dart';
import 'package:xs_life/src/features/forum/presentation/forum_create_form.dart';
import 'package:xs_life/src/features/forum/presentation/forum_screen_widget.dart';
import 'package:xs_life/src/features/main_screen/presentation/main_screen_widget.dart';

class Routes {
  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MainScreenWidget(),
      routes: [
        GoRoute(
          path: PageConstants.signIn,
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  if (state is SignedIn || state is UserCreated) {
                    var user = (state is SignedIn)
                        ? state.user
                        : (state as UserCreated).credential.user;
                    if (user == null) {
                      return;
                    }
                    if (state is UserCreated) {
                      user.updateDisplayName(user.email!.split('@')[0]);
                    }
                    if (!user.emailVerified) {
                      user.sendEmailVerification();
                      const snackBar = SnackBar(
                          content: Text(
                              'Please check your email to verify your email address'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    context.pushReplacement('/');
                  }
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: PageConstants.profile,
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
        GoRoute(
          path: PageConstants.map,
          builder: (context, state) {
            return const ExampleMapWidget();
          },
        ),
        GoRoute(
          path: PageConstants.forum,
          builder: (context, state) {
            return Consumer<AppState>(
              builder: (context, appState, _) => ForumScreenWidget(
                questions: appState.forumQuestions,
              ),
            );
          },
          routes: [
            GoRoute(
              path: 'add',
              builder: (context, state) {
                return Consumer<AppState>(
                  builder: (context, appState, _) => ForumCreateForm(
                    addQuestion: (category, topic, question) =>
                        appState.addQuestionToForum(category, topic, question),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    )
  ]);
}
