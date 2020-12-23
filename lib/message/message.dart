import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Center(
        child: RaisedButton(onPressed: (){
          Navigator.of(context).pushNamed("/about");
        },),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
