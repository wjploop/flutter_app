import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/base/page.dart';
import 'package:flutter_app/data/topic.dart';
import 'package:flutter_app/net/MyApi.dart';
import 'package:flutter_app/pages/page_recent_topic.dart';
import 'package:flutter_app/pages/page_topic_detail.dart';
import 'package:flutter_app/widgets/global_process.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/home.dart';

class TopicListParent extends StatelessWidget {
  final Widget child;

  const TopicListParent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopicListPage(tab: tabList[context.read<TabIndex>().index].href);
  }
}

class TopicListPage extends StatefulWidget {
  final String tab;

  const TopicListPage({Key key, this.tab}) : super(key: key);

  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> {
  Future<List<Topic>> _topicListFuture;

  ScrollController _scrollController;

  bool showGoTop = false;

  String tab;

  @override
  void initState() {
    super.initState();
    _topicListFuture = _getTopic();

    _scrollController = new ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        HapticFeedback.heavyImpact();
      }
      if (_scrollController.offset > 400 && showGoTop == false) {
        setState(() {
          showGoTop = true;
        });
      } else if (_scrollController.offset < 400 && showGoTop) {
        setState(() {
          showGoTop = false;
        });
      }
    });
  }

  Future<List<Topic>> _getTopic() async {
    return myApi.topic(tab);
  }

  Widget _widgetLoadMore() {
    tab = tabList[context.read<TabIndex>().index].href;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(child: Text("更多话题 >>")),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecentTopicPage(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: _topicListFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print('wolf: load data ${snapshot.data}');
          return RefreshIndicator(
            onRefresh: () {
              setState(() {
                _topicListFuture = _getTopic();
              });
              return _topicListFuture;
            },
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == snapshot.data.length) {
                      return _widgetLoadMore();
                    } else {
                      return TopicItemView(
                        topic: snapshot.data[index],
                      );
                    }
                  },
                ),
                Visibility(
                    visible: showGoTop,
                    child: Positioned(
                      right: 20,
                      bottom: 20,
                      child: FloatingActionButton(
                        child: Icon(Icons.arrow_upward),
                        onPressed: () {
                          _scrollController.animateTo(0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                      ),
                    ))
              ],
            ),
          );
        } else if (snapshot.hasError) {
          print('wolf: ${snapshot.error}');
          return Container(
            child: Column(
              children: [
                Text("Error"),
                RaisedButton.icon(
                  onPressed: () {
                    _refresh();
                  },
                  icon: Icon(Icons.refresh),
                  label: Text("retry"),
                )
              ],
            ),
          );
        }

        // default
        return LoadingView();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _refresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _topicListFuture = _getTopic();
      });
    });
  }
}

class TopicItemView extends StatefulWidget {
  final Topic topic;

  const TopicItemView({Key key, this.topic}) : super(key: key);

  @override
  _TopicItemViewState createState() => _TopicItemViewState();
}

class _TopicItemViewState extends State<TopicItemView> {
  Topic get topic => widget.topic;

  Widget _widgetLoadMore() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text("更多话题"),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TopicDetailPage(
            topic: topic,
          ),
        ));
      },
      child: Container(
        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(topic.member.avatarMini,
                            width: 32, height: 32),
                        // Image.asset("avatar.png"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(topic.member.username),
                          Row(
                            children: [
                              Text(
                                topic.lastTime,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "评论${topic.replies}",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  FlatButton(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child:
                        Text(topic.node.title, style: TextStyle(fontSize: 10)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 12),
              child: Text(
                topic.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 15,
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Loading"),
    );
  }
}
