// import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:learning/domain/auth/user.dart';
import 'package:learning/core/value_object.dart';

// extension FirebaseUserDomainX on firebase.User {
//   User toDomain() {
//     return User(
//       id: UniqueId.fromUniqueString(uid),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart' as firebase;
// import 'package:notes_firebase_ddd_course/domain/auth/user.dart';
// import 'package:notes_firebase_ddd_course/domain/core/value_objects.dart';

extension FirebaseUserDomainX on firebase.User {
  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}