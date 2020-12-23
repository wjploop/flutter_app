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

class ArrowTab extends StatefulWidget {
  bool drop;

  @override
  _ArrowTabState createState() => _ArrowTabState();
}

class Hello extends Tab {
  @override
  Widget get child => super.child;
}

class _ArrowTabState extends State<ArrowTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<Tab> get tabs => <Tab>[
        Tab(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("全部"),
                RotationTransition(
                    turns: _iconTurn, child: Icon(Icons.expand_more))
              ],
            ),
          ),
        ),
        Tab(text: "消息"),
        Tab(text: "节点")
      ];

  var pages = [
    TopicListPage(),
    MessagePage(),
    NodePage(),
  ];

  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _backgroundColorTween =
      ColorTween(begin: Colors.transparent, end: Colors.grey[50]);

  Animation<double> _iconTurn;
  Animation<double> _heightFactor;
  Animation<Color> _backgroundColor;

  AnimationController dropController;

  bool _isExpanded = false;

  bool get _isValidForDrop => _tabController.index==0;

  TabController _tabController;

  static var _tabData = [
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
    ["技术", "tech"],
  ];
  List<TabData> _tabList = _tabData.map((e) => TabData(e[0], e[1])).toList();

  @override
  void initState() {
    super.initState();
    dropController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _heightFactor = dropController.drive(_easeInTween);
    _iconTurn = dropController.drive(_halfTween.chain(_easeInTween));
    _backgroundColor =
        dropController.drive(_backgroundColorTween.chain(_easeOutTween));
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  _reverseDrop() {
    if (_isValidForDrop) {
      setState(() {
        _isExpanded = !_isExpanded;
        if (_isExpanded) {
          dropController.forward();
        } else {
          dropController.reverse();
        }
      });
    }
  }

  _dismissDrop() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = !_isExpanded;
        if (_isExpanded) {
          dropController.forward();
        } else {
          dropController.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    dropController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
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
          onTap: (value) {
            if(value==0) {
              _reverseDrop();
            }else{
              _dismissDrop();
            }
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
      body: Stack(
        children: [
          TabBarView(controller: _tabController, children: pages),
          AnimatedBuilder(
            animation: dropController,
            builder: (context, child) {
              final bool closed = _isExpanded && dropController.isDismissed;

              return Offstage(
              offstage: closed,
                child: GestureDetector(
                  onTapDown: (detail) {
                    _dismissDrop();
                  },
                  child: Container(
                    color: _backgroundColor.value,
                    constraints: BoxConstraints.expand(),
                    alignment: Alignment.topCenter,
                    child: ClipRect(
                      child:
                          Align(heightFactor: _heightFactor.value, child: child),
                    ),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: _tabList
                    .map((e) =>
                        ActionChip(label: Text(e.name), onPressed: () {}))
                    .toList(),
              ),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
