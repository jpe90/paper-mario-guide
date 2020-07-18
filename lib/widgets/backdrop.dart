import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

const flingVelocity = 2.0;

class _FrontLayer extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _FrontLayer({this.child, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: child,
    );
  }
}

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

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(children: <Widget>[
      widget.backLayer,
      PositionedTransition(
          rect: layerAnimation, child: _FrontLayer(child: widget.frontLayer))
    ]);
  }

  AnimationController _controller;

  bool get _isFrontLayerVisibile {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
      velocity: _isFrontLayerVisibile ? -flingVelocity : flingVelocity,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0,
      title: Text('Paper Mario'),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _toggleBackdropLayerVisibility();
            }),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}
