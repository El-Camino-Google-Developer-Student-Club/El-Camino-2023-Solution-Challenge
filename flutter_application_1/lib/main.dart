import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/CollegeLoc.dart';
import 'package:geocoding/geocoding.dart';
import 'College.dart';
import '/style/widgets.dart';
import 'package:provider/provider.dart';                 
import 'app_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}


const List<String> collegeList = <String>['UCLA','CSU Long Beach', 'UCI'];
const List<String> csuLongBeach = <String>['BIOL 200', 'BIOL 205', 'BIOL 207', 'CECS 105','CECS 174', 'CECS 225', 'CECS 228','CECS 229', 'CECS 274',	'CECS 277'	,'ENGR 101'	,'ENGR 102'	,'MATH 122'	,'MATH 123',	'PHYS 151 or CHEM 111A'];
const List<String> uci = <String>['I&C SCI 31 and I&C SCI 32 and I&C SCI 33',	'I&C SCI 45C',	'I&C SCI 46',	'I&C SCI 51', 'I&C SCI 53',	'I&C SCI 6B',	'I&C SCI 6D',	'I&C SCI 6N',	'IN4MATX 43',	'MATH 2A',	'MATH 2B',	'MATH 3A',	'MATH 3B',	'STATS 67'];
const List<String> uclalist = <String>['COM SCI 31', 'COM SCI 32', 'COM SCI 33', 'COM SCI 35L', 'COM SCI M51A', 'MATH 31A', 'MATH 31B', 'MATH 32A', 'MATH 32B', 'MATH 33A', 'MATH 33B', 'MATH 61', 'PHYSICS 1A and PHYSICS 1B and PHYSICS 1C', 'ENGCOMP 3', 'English Composition Courses', 'Computer programming courses: C++ preferred'];
String collegeValue = collegeList.first;
String dropdownValue = uclalist.first;
String dropdownValueCSU = csuLongBeach.first;
String dropdownValueUCI = uci.first;
bool _isVisibleCourses = false;
bool _isVisibleCollegeUCLA = false;
bool _isVisibleCollegeCSULB = false;
bool _isVisibleCollegeUCI = false;


class MyApp extends StatelessWidget {
  
  const MyApp(
    {super.key,}
  );


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //List<Marker> listOfSchools = [];
  }
  List<Marker> listOfSchools = [];

  late GoogleMap maps;

  String currentAddress = "";


  int _counter = 0;
  String currentInstitution = '';
  String transferInstitution = '';
  String transferYear = '';
  String major = '';
  String degreePlan = '';
  String FName = '';
  //static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  //CollectionReference users = FirebaseFirestore.instance.collection('UCLA');

  Future<void> getAddress(CollegeLoc coor) async{
    //String currentAddress = "";
    print("HIHIHIHI");
    print(coor.loca.latitude);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coor.loca.latitude,
        coor.loca.longitude,
      );
      //print(placemarks.length);
      Placemark place = placemarks[0];
                                            currentAddress =
                                                "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
                                           
                                      
                                            //print('CURRENT ADDRESS: $_currentAddress');
                                          } catch (e) {
                                            print("ERROR");
                                            print(e);
                                          }
  }

  @override
  Widget build(BuildContext context) {

    
    maps = GoogleMap(
                                      onMapCreated: _onMapCreated,
                                      initialCameraPosition: CameraPosition(
                                        target: _center,
                                        zoom: 11.0,
                                      ),
                                      markers: listOfSchools.toSet(),
                                    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text('Transferwise'),
          backgroundColor: Colors.blue,
          flexibleSpace: Image.asset('image.png', scale: 1,),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade300, Colors.blue.shade900],
            ),
          ),
          child: Stack(
            children: [
              
              Positioned(
                top: MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height,
                left: 0,
                right: 0,
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 700,
                      height: 800,

                    child:
                    Consumer<ApplicationState>(
                        builder: (context, appState, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Header('Add Colleges'),
                                                          
                              DropdownButton(
                                value: collegeValue,
                                items: collegeList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                    , onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        
                                        //_center = LatLng(33.88442791394878, -118.33026563209998);
                                        appState.getCoordinates(value);
                                        listOfSchools.clear();
                                        //appState.getCoordinates(value);
                                        if(value == "UCLA"){
                                          _isVisibleCollegeUCLA = true;
                                          _isVisibleCollegeCSULB = false;
                                          _isVisibleCollegeUCI = false;
                                        } else if(value == "UCI"){
                                          _isVisibleCollegeUCI = true;
                                          _isVisibleCollegeUCLA = false;
                                          _isVisibleCollegeCSULB = false;
                                        }
                                        else if (value == "CSU Long Beach"){
                                          _isVisibleCollegeCSULB = true;
                                          _isVisibleCollegeUCLA = false;
                                          _isVisibleCollegeUCI = false;
                                        }
                                        //_isVisibleCollegeUCI = true;
                                        _isVisibleCourses = false;
                                        
                                        //appState.runAction(value as String);
                                        //dropdownValue = value!;
                                        collegeValue = value!;
                                      });
                                      }
                                    ),
                            //         Visibility(
                            //           visible: _isVisibleCourses,
                            //           child: 
                            //           College(
                            //             messages: appState.college, // new
                            //           ),
                            // ),

                            Visibility(
                              visible: _isVisibleCollegeUCLA,
                              child: Column(
                              children: [
                              const Header('Add Classes'),
                              DropdownButton(
                                value: dropdownValue,
                                items: uclalist.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                    , onChanged: (String? value) {
                                      
                                      // This is called when the user selects an item.
                                      setState(() {
                                        listOfSchools.clear();
                                        maps.markers.clear();
                                        print(maps.markers.toSet().toString());
                                        
                                        _isVisibleCourses = true;
                                        
                                        double meanX = 0;
                                        double meanY = 0;
                                        //int x = 0;



                                        for(CollegeLoc coor in appState.coord){
                                          //String currentAddress = "";
                                          //currentAddress = 
                                          getAddress(coor);
                                         
                                          listOfSchools.add(
                                          Marker(
                                            markerId: MarkerId(coor.Name), position: coor.loca, infoWindow: InfoWindow(title: coor.Name, snippet: currentAddress)
                                          )
                                          
                                          );
                                          meanX += coor.loca.latitude;
                                          meanY += coor.loca.longitude;
                                        }
                                        mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(meanX/appState.coord.length, meanY/appState.coord.length), 10));
                                        
                                        
                                        appState.runAction(collegeValue, value as String);
                                        dropdownValue = value!;
                                      });
                                      }
                                    ),
                                    
                                    Visibility(
                                      visible: _isVisibleCourses,
                                      child: College(
                                        messages: appState.college, // new
                                      ),
                                    ),
                                   
                                     
                              ],
                            )
                            ),
                            Visibility(
                              visible: _isVisibleCollegeUCI,
                              child: Column(
                              children: [
                              const Header('Add Classes'),
                              DropdownButton(
                                value: dropdownValueUCI,
                                items: uci.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                    , onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        _isVisibleCourses = true;
                                        
                                        listOfSchools.clear();
                                        maps.markers.clear();
                                        print(maps.markers.toSet().toString());
                                        
                                        _isVisibleCourses = true;
                                        
                                        double meanX = 0;
                                        double meanY = 0;
                                        //int x = 0;
                                        for(CollegeLoc coor in appState.coord){
                                          print(coor.toString());
                                          int x = 0;
                                          listOfSchools.add(
                                          Marker(
                                            markerId: MarkerId(coor.Name), position: coor.loca, infoWindow: InfoWindow(title: coor.Name, snippet: "")
                                          )
                                          
                                          );
                                          meanX += coor.loca.latitude;
                                          meanY += coor.loca.longitude;
                                        }
                                        mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(meanX/appState.coord.length, meanY/appState.coord.length), 10));
                                        

                                        appState.runAction(collegeValue, value as String);
                                        dropdownValueUCI = value!;
                                      });
                                      }
                                    ),
                                    Visibility(
                                      visible: _isVisibleCourses,
                                      child: College(
                                        messages: appState.college, // new
                                      ),
                                    )        
                              ],
                            )
                            ),  
                            
                            Visibility(
                              visible: _isVisibleCollegeCSULB,
                              child: Column(
                              children: [
                              const Header('Add Classes'),
                              DropdownButton(
                                value: dropdownValueCSU,
                                items: csuLongBeach.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                    , onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        _isVisibleCourses = true;
                                        listOfSchools.clear();
                                        maps.markers.clear();
                                        print(maps.markers.toSet().toString());
                                        
                                        _isVisibleCourses = true;
                                        
                                        double meanX = 0;
                                        double meanY = 0;
                                        //int x = 0;
                                        for(CollegeLoc coor in appState.coord){
                                          print(coor.toString());
                                          int x = 0;
                                          listOfSchools.add(
                                          Marker(
                                            markerId: MarkerId(coor.Name), position: coor.loca, infoWindow: InfoWindow(title: coor.Name, snippet: "")
                                          )
                                          
                                          );
                                          meanX += coor.loca.latitude;
                                          meanY += coor.loca.longitude;
                                        }
                                        mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(meanX/appState.coord.length, meanY/appState.coord.length), 5));
                                        
                                        //print(value);
                                        appState.runAction(collegeValue, value as String);
                                        
                                        dropdownValueCSU = value!;
                                      });
                                      }
                                    ),
                                    
                                    Visibility(
                                      visible: _isVisibleCourses,
                                      child: College(
                                        messages: appState.college, // new
                                      ),
                                    )        
                              ],
                            )
                            )                                                      
                        ]
                      ),
                    ),
                    ),
                    Container(
                                        width: 700,
                                        height: 700,
                                        child:
                                    maps,
              )  ,
                  ],
                ),
                
              ),
            
            ],
          
          ),
          
        ),
        
      );
  }
}
