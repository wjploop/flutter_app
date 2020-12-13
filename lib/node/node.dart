import 'package:flutter/material.dart';
import 'package:flutter_app/base/page.dart';
import 'package:flutter_app/data/node.dart';
import 'package:flutter_app/net/Api.dart';

class NodePage extends StatefulWidget {
  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> with AutomaticKeepAliveClientMixin {
  final data = <Node>[];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListPage<Node>(data , _getData, getItemBuilder());
  }

  Future<List<Node>> _getData() {
    return api.getNodes().then((List<Node> nodes) {
      nodes.sort((Node a,Node b)=> b.stars.compareTo(a.stars));
      nodes.take(100);
      return nodes;
    });
  }

  IndexedWidgetBuilder getItemBuilder() {
    return (BuildContext context, index) {
      return Card(
        child: Center(
          child: Text(data[index].title),
        ),
      );
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class ParentNode{
  final Node parent;
  final List<Node> children;

  ParentNode(this.parent, this.children);
}

const parents = [
  "分享与探索",
  "V2EX",
  "Apple",
  "前端开发",
  "编程语言",
  "后端架构",
];