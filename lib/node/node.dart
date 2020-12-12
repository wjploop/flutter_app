import 'package:flutter/material.dart';
import 'package:flutter_app/base/page.dart';
import 'package:flutter_app/data/node.dart';
import 'package:flutter_app/net/Api.dart';

class NodePage extends StatefulWidget {
  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {
  final data = <Node>[];

  @override
  Widget build(BuildContext context) {
    return ListPage<Node>(data , _getData, getItemBuilder());
  }

  Future<List<Node>> _getData() {
    return api.getNodes().then((List<Node> nodes) {
      nodes.retainWhere((Node element) => element.parentNodeName == "v2ex");
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
}
