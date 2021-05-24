import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:provider/provider.dart';
import 'package:tridhee_application_1/blocs/application_bloc.dart';
import 'package:tridhee_application_1/screens/todo_screen.dart';

GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text(
            'Where do you want to Park ?',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 20.0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      key: _drawerKey, // This way it will not open
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('TODO LIST'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoList()),
                );
              },
            ),
          ],
        ),
      ),
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height),
                  child: GoogleMap(
                    key: _key,
                    mapType: MapType.roadmap,
                    mobilePreferences: MobileMapPreferences(
                      myLocationEnabled: true,
                    ),
                    initialPosition: GeoCoord(
                        applicationBloc.currentLocation.latitude,
                        applicationBloc.currentLocation.longitude),
                    initialZoom: 15.0,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 15,
                  left: 15,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          splashColor: Colors.grey,
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            _drawerKey.currentState.openDrawer();
                          },
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                hintText: "Search..."),
                          ),
                        ),
                        IconButton(
                          splashColor: Colors.grey,
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
