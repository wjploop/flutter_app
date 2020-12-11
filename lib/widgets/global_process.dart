import 'package:flutter/material.dart';

class GlobalProcessBar extends StatefulWidget {
  const GlobalProcessBar({Key key, this.child}) : super(key: key);

  @override
  _GlobalProcessBarState createState() => _GlobalProcessBarState();

  final Widget child;
}

class _GlobalProcessBarState extends State<GlobalProcessBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Center(
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10)),
            width: 300,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 7.0,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Text(
                      "Loading...",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).indicatorColor),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
