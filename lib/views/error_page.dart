import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ErrorPage extends StatelessWidget {
  final String errorInfo;

  ErrorPage({@required this.errorInfo});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('An error occured: $errorInfo'),
    );
  }
}
