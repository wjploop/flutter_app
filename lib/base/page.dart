import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/node/node.dart';
import 'package:flutter_app/widgets/global_process.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef PageItemBuilder<T> = Widget Function(BuildContext context, int index, List<T> items);


class ListPage<T> extends StatefulWidget {
  @override
  _ListPageState<T> createState() => _ListPageState();

  final Function getData;

  final PageItemBuilder<T> pageItemBuilder;

  ListPage(
    this.getData,
    this.pageItemBuilder,
  );
}

class _ListPageState<T> extends State<ListPage> {
  List<T> items = List.empty(growable: true);
  bool isFirstLoad = true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    widget.getData().timeout(Duration(seconds: 5)).then((value) {
      if (mounted) {
        setState(() {
          items.clear();
          items.addAll(value);
        });
      }
    }).catchError(
      (error) {
        var errorStr = "";
        switch (error) {
          case TimeoutException:
            break;
          default :
            // errorStr = errorStr.runtimeType.toString();
            break;
        }
        errorStr = error.runtimeType.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorStr)));
      }
    ).whenComplete(() {
        if (isFirstLoad) {
          isFirstLoad = false;
          GlobalProcessBar.of(context).showProcess = false;
        }
        _refreshController.refreshCompleted();
      });
  }

  void _onLoading() async {
    widget.getData<T>().timeout(Duration(seconds: 5)).then((value) {
      items.addAll(value);
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
          itemCount: items.length, itemBuilder:  widget.pageItemBuilder,),
    );
  }
}
