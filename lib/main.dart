import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';
import 'package:tridhee_application_1/screens/home_screen.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:tridhee_application_1/loading.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  GoogleMap.init('AIzaSyCRE9snsAv8gveeFgaTP8GRjAS2WbfB6HE');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text(snapshot.error.toString())),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        return ChangeNotifierProvider(
          create: (context) => ApplicationBloc(),
          child: MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.grey[900],
              primarySwatch: Colors.pink,
            ),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}
