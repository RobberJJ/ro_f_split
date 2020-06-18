import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoFSplitMasterPage extends StatefulWidget {
  final String title;
  final GlobalKey<NavigatorState> navigatorState;
  RoFSplitMasterPage({
    this.title,
    this.navigatorState,
  });
  @override
  _RoFSplitMasterPageState createState() => _RoFSplitMasterPageState();
}

class _RoFSplitMasterPageState extends State<RoFSplitMasterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Master page ' + (widget.title ?? ''),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: InkWell(
        onTap: () {
          if (widget.navigatorState != null)
            widget.navigatorState.currentState.push(MaterialPageRoute(
                builder: (context) => RoFSplitMasterPage(
                  title: (int.parse(widget.title??'0') + 1).toString(),
                  navigatorState: widget.navigatorState,
                )));
        },
      ),
    );
  }
}
