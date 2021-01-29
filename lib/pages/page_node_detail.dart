
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/node_detail.dart';
import 'package:flutter_app/net/MyApi.dart';

class NodeDetailPage extends StatefulWidget {
  final String nodeId;
  final String nodeName;

  NodeDetailPage(this.nodeId, this.nodeName);

  @override
  _NodeDetailPageState createState() => _NodeDetailPageState();
}

class _NodeDetailPageState extends State<NodeDetailPage> {

  ScrollController _scrollController = new ScrollController();

  NodeDetail _nodeDetail;

  int page = 1;
  int maxPage= 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(page == maxPage) {
          HapticFeedback.heavyImpact();
        }else{
          _getData();

        }
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        AppBar()
      ],
    );
  }

  Future<void> _getData() async {
    myApi.nodes()
  }
}
