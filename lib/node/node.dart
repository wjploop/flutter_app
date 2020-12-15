import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/page.dart';
import 'package:flutter_app/data/node.dart';
import 'package:flutter_app/net/Api.dart';
import 'package:flutter_app/net/MyApi.dart';

class NodePage extends StatefulWidget {
  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage>
    with AutomaticKeepAliveClientMixin {
  final data = <NodeParent>[];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListPage<NodeParent>(data, _getData, getItemBuilder());
  }

  Future<List<NodeParent>> _getData() {
    // return api.getNodes().then((List<Node> nodes) {
    //   nodes.sort((Node a,Node b)=> b.stars.compareTo(a.stars));
    //   nodes.take(100);
    //   return nodes;
    // }
    return myApi.nodes();
  }

  IndexedWidgetBuilder getItemBuilder() {
    return (BuildContext context, index) {
      NodeParent nodeParent = data[index];
      return Container(
        child: Column(
          children: [
            Text(nodeParent.parent),
            ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: nodeParent.nodes
                  .map((e) => ListTile(title: Text(e.name)))
                  .toList(),
            )
          ],
        ),
      );
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class ParentNode {
  final Node parent;
  final List<Node> children;

  ParentNode(this.parent, this.children);
}
