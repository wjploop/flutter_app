import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/drawer.dart';
import 'package:flutter_app/message/message.dart';
import 'package:flutter_app/net/MyApi.dart';
import 'package:flutter_app/node/node.dart';
import 'package:flutter_app/topic/topic.dart';
import 'package:provider/provider.dart';

var homeKey = GlobalKey<ScaffoldState>();

var _tabData = [
  ["全部", "all"],
  ["技术", "tech"],
  ["创意", "creative"],
  ["好玩", "play"],
  ["Apple", "apple"],
  ["酷工作", "jobs"],
  ["交易", "deals"],
  ["城市", "city"],
  ["问与答", "qna"],
  ["最热", "hot"],
  ["R2", "r2"],
  ["节点", "nodes"],
  ["关注", "members"],
];
List<TabData> tabList = _tabData.map((e) => TabData(e[0], e[1])).toList();

int tabIndex = 0;

class TabIndex with ChangeNotifier {
  int _index = 0;

  int get index {
    return _index;
  }

  set index(int value) {
    _index = value;
    notifyListeners();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // int index = 0;

  List<Tab> tabs() {
    print('home state index = ${context.watch<TabIndex>().index}');
    return <Tab>[
      Tab(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tabList[context.watch<TabIndex>().index].name),
              RotationTransition(
                  turns: _iconTurn, child: Icon(Icons.expand_more))
            ],
          ),
        ),
      ),
      Tab(text: "消息"),
      Tab(text: "节点")
    ];
  }

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
      ColorTween(begin: Colors.transparent, end: Colors.black12);

  Animation<double> _iconTurn;
  Animation<double> _heightFactor;
  Animation<Color> _backgroundColor;

  AnimationController dropController;

  bool _isExpanded = false;

  bool get _isValidForDrop => _tabController.index == 0;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    dropController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _heightFactor = dropController.drive(_easeInTween);
    _iconTurn = dropController.drive(_halfTween.chain(_easeInTween));
    _backgroundColor =
        dropController.drive(_backgroundColorTween.chain(_easeOutTween));
    _tabController = TabController(length: 3, vsync: this);
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
          tabs: tabs(),
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          onTap: (value) {
            if (value == 0) {
              _reverseDrop();
            } else {
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
              final bool closed = !_isExpanded && dropController.isDismissed;

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
                      child: Align(
                          heightFactor: _heightFactor.value, child: child),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: GridView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                ),
                children: tabList
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                              color: Theme.of(context).primaryColor,
                              child: Text(e.name),
                              onPressed: () {
                                context.read<TabIndex>().index =
                                    tabList.indexOf(e);
                                _dismissDrop();
                              }),
                        ))
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
