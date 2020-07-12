import 'package:flutter/material.dart';
import 'widgets/backdrop.dart';
import 'pages/collectibles_page.dart';
import 'models/collectibles_repository.dart';

void main() {
  runApp(MyApp());
}

enum LoadStatus { loading, completed, error }

class MyApp extends StatefulWidget {
  MyApp() : repository = CollectiblesRepository();
  final CollectiblesRepository repository;

  @override
  createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoadStatus status = LoadStatus.loading;

  @override
  void initState() {
    super.initState();
    widget.repository.loadCollectiblesFromJson().then((collectibles) {
      widget.repository.collectibles = collectibles;
      setState(() => status = LoadStatus.completed);
    }).catchError((err) => setState(() => status = LoadStatus.error));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Backdrop(
        frontLayer:
            status == LoadStatus.loading ? Text('loading') : CollectiblesPage(),
        backLayer: Container(color: Colors.blue),
      ),
    );
  }
}
