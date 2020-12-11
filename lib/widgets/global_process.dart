import 'package:flutter/material.dart';

class GlobalProcessBar extends StatefulWidget {
  const GlobalProcessBar({Key key, this.child}) : super(key: key);

  @override
  GlobalProcessBarState createState() => GlobalProcessBarState();

  final Widget child;

  static GlobalProcessBarState of(BuildContext context) {
    final GlobalProcessBarState state = context.findAncestorStateOfType<GlobalProcessBarState>();
    return state;
  }
}

class GlobalProcessBarState extends State<GlobalProcessBar> {
  bool show = false;

  set showProcess (bool show){
    setState(() {
      this.show = show;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Visibility(
          visible: show,
          child: Container(
            color: Colors.transparent,
            child: Center(
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
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).indicatorColor),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
