import 'package:flutter/material.dart';
import 'package:flutter_app/drawer.dart';
import 'package:flutter_app/message/message.dart';
import 'package:flutter_app/net/MyApi.dart';
import 'package:flutter_app/node/node.dart';
import 'package:flutter_app/topic/topic.dart';

var homeKey = GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var tabs = <Tab>[Tab(text: "全部"), Tab(text: "消息"), Tab(text: "节点")];

  var pages = [
    NodePage(),
    TopicListPage(),
    MessagePage(),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeKey,
      appBar: AppBar(
        title: Center(child: Text("V2EX")),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            homeKey.currentState.openDrawer();
          },
        ),
        bottom: TabBar(
          tabs: tabs,
          controller: _tabController,
          onTap: (value) async {
            var tabs = await myApi.tabList();
            print('hello');
            showDialog<Dialog>(
              context: context,
              builder: (context) {
                return Builder(
                  builder: (context) => Wrap(
                    children: tabs
                        .map((TabData e) =>
                            ActionChip(label: Text(e.name), onPressed: () {}))
                        .toList(),
                  ),
                );
              },
            );
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //todo search
              })
        ],
      ),
      body: TabBarView(controller: _tabController, children: pages),
      drawer: AppDrawer(),
    );
  }
}
