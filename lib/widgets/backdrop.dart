import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

class Backdrop extends StatefulWidget {
  @override
  createState() => _BackdropState();

  final Widget backLayer;
  final Widget frontLayer;

  const Backdrop({
    @required this.frontLayer,
    @required this.backLayer,
  })  : assert(frontLayer != null),
        assert(backLayer != null);
}

class _BackdropState extends State<Backdrop> {
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    return Stack(children: <Widget>[widget.backLayer, widget.frontLayer]);
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(title: Text('Paper Mario'));

    logger.d('hmm');
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}
