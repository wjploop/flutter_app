import 'package:flutter/material.dart';

void main() {
    runApp(MaterialApp(
      home: Scaffold(
        body: NotificationDemo(),
      ),
    ));
}

class NotificationDemo extends StatefulWidget {
  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  var _tabs = ["month", 'day'];
  var _months = ["January", "February", "March"];
  var _days = ["Sunday", "Monday", "Tuesday"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if(notification.depth==0) {
                print(notification);
              }
              return true;
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: Text("title"),
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      tabs: _tabs
                          .map((name) => Tab(
                                text: name,
                              ))
                          .toList(),
                    ),
                  )
                ];
              },
              body: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: _months.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(_months[index]),
                    ),
                  ),
                  ListView.builder(
                    itemCount: _days.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(_days[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
