import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ErrorPage extends StatelessWidget {
  final String errorInfo;

  const ErrorPage({@required this.errorInfo});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('FUUU An error occured: $errorInfo'),
    );
  }
}
