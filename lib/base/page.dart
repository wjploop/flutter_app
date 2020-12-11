import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef GetData<T> = Future<List<T>> Function<T>();

class Page<T> extends StatefulWidget {
  @override
  _PageState<T> createState() => _PageState();

  final GetData<T> getData;
  final GlobalKey<ScaffoldState> scaffoldKey;

  Page(this.getData, this.scaffoldKey,);
}

class _PageState<T> extends State<Page> {
  List<T> items = [];

  ScaffoldState _scaffoldState;

  get() => widget.scaffoldKey.currentState;

  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  void _onRefresh() async {
    // monitor network fetch

    widget.getData<T>().timeout(Duration(seconds: 5)).then((value) {
      items.clear();
      items.addAll(value);
      if (mounted) {
        setState(() {});
      }
    }).catchError(() {
      _scaffoldState.showSnackBar(SnackBar(content:Text("Time Out")));
    }, test: (error) => error is TimeoutException,)
    .catchError((){
      _scaffoldState.showSnackBar(SnackBar(content: Text("Unknown Error")));
    }).whenComplete(() => {
      _scaffoldState.
    });

    if (mounted) {
      setState(() {});
    }
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
