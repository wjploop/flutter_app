import 'package:flutter/material.dart';
import 'package:flutter_app/component/listview_recent_topics.dart';

class RecentTopicPage extends StatefulWidget {
  @override
  _RecentTopicPageState createState() => _RecentTopicPageState();
}

class _RecentTopicPageState extends State<RecentTopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("最近主题"),
      ),
      body: ListViewRecentTopics(),
    );
  }
}
