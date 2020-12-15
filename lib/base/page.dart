import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/node/node.dart';
import 'package:flutter_app/widgets/global_process.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListPage<T> extends StatefulWidget {
  @override
  ListPageState<T> createState() => ListPageState();

  final List<T> data;

  final Function getData;

  final IndexedWidgetBuilder itemBuilder;

  ListPage(this.data, this.getData, this.itemBuilder);
}

class ListPageState<T> extends State<ListPage> {
  bool isFirstLoad = true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    widget.getData().timeout(Duration(seconds: 10)).then((List<T> value) {
      if (mounted) {
        setState(() {
          if (value.isEmpty) {
            _refreshController.loadNoData();
          } else {
            widget.data.clear();
            widget.data.addAll(value);
          }
        });
      }
    }).catchError((error) {
      var errorStr = "";
      switch (error.runtimeType) {
        case TimeoutException:
          break;
        default:
          // errorStr = errorStr.runtimeType.toString();
          break;
      }
      errorStr = error.runtimeType.toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorStr)));
    }).whenComplete(() {
      if (isFirstLoad) {
        isFirstLoad = false;
        GlobalProcessBar.of(context).showProcess = false;
      }
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    widget.getData<T>().timeout(Duration(seconds: 5)).then((value) {
      widget.data.addAll(value);
      if (mounted) {
        setState(() {});
      }
    }).catchError(
      (error) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Time Out")));
        _refreshController.loadFailed();
      },
      test: (error) => error is TimeoutException,
    ).catchError((error) {
      print(error.runtimeType);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(error.stackTrace.toString())));
    }).whenComplete(() {
      GlobalProcessBar.of(context).showProcess = false;
      _refreshController.loadComplete();
    });

    GlobalProcessBar.of(context).showProcess = true;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullUp: true,
      child: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}
