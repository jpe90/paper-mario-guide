import 'package:flutter/material.dart';
import 'package:paper_mario_guide/views/collectibles_view.dart';
import 'widgets/backdrop.dart';
import 'views/collectibles_view.dart';
import 'models/collectibles_repository.dart';
import 'views/error_page.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

void main() {
  runApp(MyApp());
}

enum LoadStatus { loading, completed, error }

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoadStatus status = LoadStatus.loading;
  CollectiblesRepository repository;

  @override
  void initState() {
    super.initState();
    repository = CollectiblesRepository();
    repository.loadCollectiblesFromJson().then((collectibles) {
      CollectiblesRepository.collectibles = collectibles;
      setState(() => status = LoadStatus.completed);
    }).catchError((err) {
      logger.e(err.toString());
      setState(() => status = LoadStatus.error);
    });
  }

  Widget getFrontLayerForLoadStatus(LoadStatus status) {
    if (status == LoadStatus.loading) {
      return Text('loading');
    } else if (status == LoadStatus.completed) {
      return CollectiblesView(
          collectibles: CollectiblesRepository.collectibles);
    } else
      return ErrorPage(errorInfo: "shrug");
  }

  // This widget is the root of your application.p
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'mario'),
      home: Backdrop(
        frontLayer: getFrontLayerForLoadStatus(status),
        //status == LoadStatus.loading ? Text('loading') : CollectiblesPage(),
        backLayer: Container(color: Colors.blue),
      ),
    );
  }
}
