import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/widgets/global_process.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

final GlobalKey<GlobalProcessBarState> progressBarKey =
    GlobalKey<GlobalProcessBarState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.grey[200], accentColor: Colors.black),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: (settings) {
      //   return
      // },
      navigatorObservers: [MyNavigatorObserver()],
      home: GlobalProcessBar(child: MultiProvider(
        providers: [
          ChangeNotifierProvider<TabIndex>(create: (context) => TabIndex(),)
        ],
        child: Home(),
      ),),
      routes: <String, WidgetBuilder>{
        "/about": (context) => Scaffold(
          appBar: AppBar(
            title: Text("about"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("10086"),
                FlatButton(
                  child: Text("Call me"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/test1234");
                  },
                ),
              ],
            ),
          ),
        ),
        "/contact": (context) => Scaffold(
          appBar: AppBar(
            title: Text("Contact"),
          ),
        )
      },
      onGenerateRoute: (settings) => PageRouteBuilder(
        opaque: false,
        // barrierColor: Colors.blueGrey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: RotationTransition(
                turns: Tween(begin: 0.9, end: 1.0).animate(animation),
                child: child),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(
              child: Center(
                child: Text("test"),
              ));
        },
      ),
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("navigator push: from $previousRoute  to $route");
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
