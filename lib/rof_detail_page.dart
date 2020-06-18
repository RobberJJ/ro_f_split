import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoFSplitDetailPage extends StatefulWidget {
  final String title;
  final GlobalKey<NavigatorState> navigatorState;
  RoFSplitDetailPage({
    this.title,
    this.navigatorState,
  });
  @override
  _RoFSplitDetailPageState createState() => _RoFSplitDetailPageState();
}

class _RoFSplitDetailPageState extends State<RoFSplitDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail page ' + (widget.title ?? ''),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: InkWell(
        onTap: () {
          if (widget.navigatorState != null)//widget.navigatorState.currentState
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RoFSplitDetailPage(
                      title: (int.parse(widget.title) + 1).toString(),
                      navigatorState: widget.navigatorState,
                    )));
        },
      ),
    );
  }
}
