import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return ListPage<NodeParent>(
      data,
      _getData,
      getItemBuilder(),
      enableLoadMore: false,
    );
  }

  Future<List<NodeParent>> _getData() {
    return myApi.nodes();
  }

  IndexedWidgetBuilder getItemBuilder() {
    return (BuildContext context, index) {
      NodeParent nodeParent = data[index];
      return Container(
        margin: EdgeInsets.only(left: 12, right: 12,top: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8,bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 3,
                    height: 16,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(nodeParent.parent),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: nodeParent.nodes
                    .map((e) => ActionChip(
                          visualDensity: VisualDensity.comfortable,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          backgroundColor: Colors.grey[200],
                          label: Text(
                            e.name,
                            style: TextStyle(fontSize: 13),
                          ),
                          onPressed: () {},
                        ))
                    .toList(),
              ),
            ),
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
