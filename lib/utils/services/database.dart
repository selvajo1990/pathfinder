import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pathfinder/models/firebase_auth.dart';

class CheckUserAccess {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userAccount =
      FirebaseFirestore.instance.collection('userAccount');

  // sign in
  Future signIn() async {
    try {
      UserCredential _userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: 'email', password: 'password');
      User _user = _userCredential.user;
      return _userFromFirebase(_user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserInformation> signWithFirebase(
      String email, String password) async {
    try {
      UserCredential _userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(_userCredential.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // auth state change
  Stream<UserInformation> get userState {
    // return _firebaseAuth
    //     .authStateChanges()
    //     .map((event) => _userFromFirebase(event));
    // .map(_userFromFirebase);

    // _firebaseAuth.authStateChanges().map((event) async {
    //   print('event.uid');
    //   await _userAccount.doc(event.uid).get().then((doc) {
    //     print(doc.data()['isAdminVerified']);
    //   });
    //   return _userFromFirebase(event);
    // });
    // return null;
    return _firebaseAuth
        .authStateChanges()
        .asyncMap((event) => _newUserFromFirebase(event));
  }

  Future<UserInformation> _newUserFromFirebase(User user) async {
    await _userAccount
        .doc(user != null ? user.uid : 'DEFAULT')
        .get()
        .then((documentSnapshot) => print(documentSnapshot.exists
            ? documentSnapshot.data()['isAdminVerified']
            : 'no data'))
        .catchError((onError) => print(onError));
    return user != null
        ? UserInformation(emailId: user.email, isAdmin: false, uid: user.uid)
        : null;
  }

  Future signOut() async {
    return await _firebaseAuth.signOut();
  }

  // assign to custom class from firebase user
  UserInformation _userFromFirebase(User user) {
    return user != null
        ? UserInformation(emailId: user.email, isAdmin: false, uid: user.uid)
        : null;
  }
}
