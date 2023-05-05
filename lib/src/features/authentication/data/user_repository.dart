import 'package:firebase_auth/firebase_auth.dart';
import 'package:xs_life/src/features/authentication/data/user_repository_interface.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class UserRepository extends IUserRepository {
  @override
  Future<void> checkLoggedInUser(User user) async {
    var userDoc = await collection.where("user_key", isEqualTo: user.uid).get();
    if (userDoc.size < 1) {
      UserDetail userDetail = UserDetail(user.uid, user.displayName.toString(),
          user.displayName.toString(), "");
      await createUser(userDetail);
    }
  }

  @override
  Future<void> createUser(UserDetail userDetail) async {
    await collection.add(userDetail.toMap());
  }

  @override
  Future<UserDetail?> getUserDetails(uid) async {
    var userDoc = await collection.where("user_key", isEqualTo: uid).get();
    if (userDoc.size > 0) {
      var data = userDoc.docs[0].data();
      return UserDetail.fromMap(userDoc.docs[0].data());
    }
    return null;
  }
}
