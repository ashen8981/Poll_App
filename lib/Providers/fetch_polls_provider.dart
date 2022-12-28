
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FetchPollsProvider extends ChangeNotifier {
  List<DocumentSnapshot> _pollsList = [];
  List<DocumentSnapshot> _usersPollsList = [];

  bool _isLoading = true;

  ///
  bool get isLoading => _isLoading;

  List<DocumentSnapshot> get pollsList => _pollsList;
  List<DocumentSnapshot> get userPollsList => _usersPollsList;

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference pollCollection =
  FirebaseFirestore.instance.collection("polls");

  //fetch all polls
  void fetchAllPolls() async {
    pollCollection.get().then((value) {
      if (value.docs.isEmpty) {
        _pollsList = [];
        _isLoading = false;
        notifyListeners();
      } else {
        final data = value.docs;

        _pollsList = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  //fetch user polls
  void fetchUserPolls() async {
    pollCollection.get().then((value) {
      if (value.docs.isEmpty) {
        _usersPollsList = [];
        _isLoading = false;
        notifyListeners();
      } else {
        final data = value.docs;

        _usersPollsList = data;
        _isLoading = false;
        notifyListeners();
      }
    });
  }
}