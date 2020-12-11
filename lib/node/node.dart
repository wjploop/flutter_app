import 'package:flutter/material.dart';
import 'package:flutter_app/base/page.dart';
import 'package:flutter_app/data/node.dart';
import 'package:flutter_app/net/Api.dart';

class NodePage extends StatefulWidget {
  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {
  @override
  Widget build(BuildContext context) {
    return ListPage<Node>(_getData, itemBuilder);
  }

  _getData(){
    return api.getNodes();
  }
}



var itemBuilder = (context, index,List<Node> items) => Card(
      child: Center(
        child: Text(items[index].name),
      ),
    );
