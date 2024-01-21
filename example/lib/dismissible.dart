import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class DismissiblePage extends StatefulWidget {
  DismissiblePage({Key? key}) : super(key: key);

  @override
  _DismissiblePageState createState() => _DismissiblePageState();
}

class _DismissiblePageState extends State<DismissiblePage>
    with SingleTickerProviderStateMixin {
  late RubberAnimationController _controller;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        //lowerBoundValue: AnimationControllerValue(percentage: 0.0),
        upperBoundValue: AnimationControllerValue(percentage: 0.9),
        duration: Duration(milliseconds: 200),
        dismissible: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dismissible",
          style: TextStyle(color: Colors.cyan[900]),
        ),
      ),
      body: Container(
        child: RubberBottomSheet(
          onDragEnd: () {
            print("onDragEnd");
          },
          scrollController: _scrollController,
          lowerLayer: _getLowerLayer(),
          upperLayer: _getUpperLayer(),
          animationController: _controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.expand();
        },
      ),
    );
  }

  Widget _getLowerLayer() {
    return Container(
      decoration: BoxDecoration(color: Colors.cyan[100]),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(color: Colors.cyan),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("Item $index"));
          },
          itemCount: 20),
    );
  }
}
