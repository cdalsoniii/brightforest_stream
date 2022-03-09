import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BrightforestStreamFirebaseUser {
  BrightforestStreamFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

BrightforestStreamFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BrightforestStreamFirebaseUser> brightforestStreamFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BrightforestStreamFirebaseUser>(
            (user) => currentUser = BrightforestStreamFirebaseUser(user));
