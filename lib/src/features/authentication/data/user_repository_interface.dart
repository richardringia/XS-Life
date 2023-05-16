import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

abstract class IUserRepository {
  var collection = FirebaseFirestore.instance.collection('users');

  Future<void> checkLoggedInUser(User user);
  Future<void> createUser(UserDetail userDetail);
  Future<void> updateUser(UserDetail userDetail);
  Future<bool> isUserEmpty(User user);
  Future<UserDetail?> getUserDetails(uid);
}