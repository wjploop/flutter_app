import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(leading: Icon(Icons.hot_tub),title: Text("今日热门"),),
          ListTile(leading: Icon(Icons.follow_the_signs),title: Text("特别关注"),),
          ListTile(leading: Icon(Icons.collections),title: Text("收藏"),),
        ],
      ),
    );
  }
}
