import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/CollegeCourses.dart';
import 'package:flutter_application_1/CollegeLoc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  List<CollegeCourses> _college = [];
  List<CollegeLoc> hi = [];
  List<CollegeLoc> get coord => hi;
  List<CollegeCourses> get college => _college;
  
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  String classClass = "COM SCI 31";
  bool get loggedIn => _loggedIn;
  String word = "";
  StreamSubscription<QuerySnapshot>? db;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    // db =  FirebaseFirestore.instance.
    //     collection("UCLA")
    //     .snapshots()
    //     .listen((event) {
    //       _college = [];
    //       for(final document in event.docs){
    //         //document.toString();
    //         _college.add(
    //           CollegeCourses(
    //             "UCLA",
    //             document.data()["Name"] as String,
    //             document.data()["COM SCI 31"]
    //           ),
    //       );
    //   }
    //   notifyListeners();
    // });
    // notifyListeners();
  }

  void runAction(String classes, String name){
        db =  FirebaseFirestore.instance.
        collection(classes)
        .snapshots()
        .listen((event) {
          _college = [];
          for(final document in event.docs){
            print(document.data()["Name"] as String);
            print(document.data()[name]);
            
            //document.toString();
            _college.add(
              CollegeCourses(
              classes, 
              document.data()["Name"] as String,
              document.data()[name])
          );
        //print(document.data().keys); // Access the info inside each
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void getCoordinates(String? school) async {

    db =  FirebaseFirestore.instance.
        collection(school!)
        .snapshots()
        .listen((event) {
          print(school);
          hi = [];
          for(final document in event.docs){
            print(document.data()["Name"]);
            hi.add(
              CollegeLoc(
              document.data()["Name"],
              LatLng(document.data()["longitude"] as double, document.data()["latitude"] as double)
              )
            );
            print("HIHI");
            
        //print(document.data().keys); // Access the info inside each
      }
      notifyListeners();
    });
    notifyListeners();
    
  }
}