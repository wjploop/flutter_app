import 'package:flutter/material.dart';
import 'package:flutter_app/data/topic.dart';
import 'package:flutter_app/net/MyApi.dart';
import 'package:flutter_app/topic/topic.dart';

class ListViewRecentTopics extends StatefulWidget {
  @override
  _ListViewRecentTopicsState createState() => _ListViewRecentTopicsState();
}

class _ListViewRecentTopicsState extends State<ListViewRecentTopics> {
  int p = 1;
  bool isUpLoading = false;
  List<Topic> items = List();
  ScrollController _scrollController = ScrollController();

  _getTopics() async {
    if (!isUpLoading) {
      isUpLoading = true;
      List<Topic> newItems = await myApi.topic("recent", page: p++);

      setState(() {
        items.addAll(newItems);
        isUpLoading = false;
      });
    }
  }

  _refresh() async {
    p = 0;
    List<Topic> newItems = await myApi.topic("recent", page: p);
    setState(() {
      items.clear();
      items.addAll(newItems);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        _getTopics();
      }
    });
    _getTopics();
  }

  @override
  Widget build(BuildContext context) {
    if (items.length > 0) {
      return RefreshIndicator(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("加载第${p}页"),
              );
            } else {
              return TopicItemView(topic: items[index]);
            }
          },
        ),
        onRefresh: () => _refresh(),
      );
    }
    return LoadingView();
  }
}
