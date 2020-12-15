import 'package:flutter/material.dart';

void main() {
  runApp(AutomaticKeepAlive(
    child: MaterialApp(
      routes: <String, WidgetBuilder>{
        "/": (context) => Page1(),
        "/2": (context) => Page2(),
      },
    ),
  ));
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    print("${this.context} build , this element depth is ${(context as Element).depth}");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(),
            RaisedButton(
                child: Text("next"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/2");
                })
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("${this.context} build , this element depth is ${(context as Element).depth}");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(),
          RaisedButton(
              child: Text("back"),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
