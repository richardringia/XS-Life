import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';

class AuthenticationActions {
  static final forgotPassword = ForgotPasswordAction(((context, email) {
    final uri = Uri(
      path: '/sign-in/forgot-password',
      queryParameters: <String, String?>{
        'email': email,
      },
    );
    context.push(uri.toString());
  }));

  static final authStateChangeAction = AuthStateChangeAction(
    ((context, state) {
      if (state is SignedIn || state is UserCreated) {
        UserRepository userRepo = UserRepository();

        // step 1: get user object and check if not null
        var user = (state is SignedIn)
            ? state.user
            : (state as UserCreated).credential.user;
        if (user == null) {
          return;
        }

        // step 2: get user details
        if (state is UserCreated) {
          user.updateDisplayName(user.email!.split('@')[0]);
        }

        // step 3: check if the data model is created in the collection
        userRepo.checkLoggedInUser(user);

        if (!user.emailVerified) {
          user.sendEmailVerification();
          const snackBar = SnackBar(
              content: Text(
                  'Please check your email to verify your email address'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (context.canPop()) {
          context.pop();
        } else {
          context.pushReplacement('/');
        }
      }
    }),
  );
}
