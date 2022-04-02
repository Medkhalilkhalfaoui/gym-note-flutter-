import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monster_gym/listexpanded.dart';
import 'package:monster_gym/register.dart';



Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      //home: MyHomePage(),
      routes: {
        '/': (context) => MyHomePage(),
        '/new': (context) => FormPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MONSTER GYM',
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.group,
                  color: Colors.red,
                ),
                text: "les abonnés",
              ),
              Tab(
                icon: Icon(
                  Icons.add,
                  color: Colors.red,
                ),
                text: "nouvel abonné",
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white70,
        ),
        body: TabBarView(
          children: <Widget>[
            MyStatefulWidget(),
            FormPage(),
          ],
        ),

      ),
    );
  }
}
