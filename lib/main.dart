//asıl main fonksiyonu

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/provider/ad_settings_provider.dart';
import 'package:gridapp/provider/carousel_provider.dart';
import 'package:gridapp/provider/first_open_provider.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:gridapp/provider/image_resize_provider.dart';
import 'package:gridapp/provider/pick_image_provider.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:gridapp/provider/split_image_provider.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:gridapp/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import 'components/remote_config/remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RemoteConfigService r = RemoteConfigService();
  await r.setRemoteConfig();

  await UnityAds.init(
    gameId: "5324011",
    testMode: true,
    onComplete: () {
      print('Initialization Complete');
    },
    onFailed: (error, message) =>
        print('Initialization Failed: $error $message'),
  );
  AmplitudeConnection.connect_amplitude();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late RemoteConfigService remoteService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remoteService = RemoteConfigService();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GridProvider()),
          ChangeNotifierProvider(create: (context) => CarouselProvider()),
          ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
          ChangeNotifierProvider(create: (context) => SplitImageProvider()),
          ChangeNotifierProvider(create: (context) => ImageResizeProvider()),
          ChangeNotifierProvider(create: (context) => PacksProvider()),
          ChangeNotifierProvider(create: (context) => AdSettingsProvider()),
          ChangeNotifierProvider(create: (context) => FirstOpenProvider()),
          ChangeNotifierProvider(create: (context) => RateUsProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 0, // Set elevation to 0 to hide the bottom line
            ),
            fontFamily: "MyFont",
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(), // GridImagePage(),  //ImageSplitWidget(),
        ));
  }
}

/*

import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/components/remote_config/remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late RemoteConfigService remoteService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remoteService = RemoteConfigService();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: remoteService.setRemoteConfig(),
          builder: (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return HomePage(snapshot.requireData, remoteService);
            }
            return Center(
              child: Text("err"),
            );
          }),
    );
  }
}

class HomePage extends StatelessWidget {
  final FirebaseRemoteConfig remoteConfigData;
  final RemoteConfigService remoteService;
  const HomePage(this.remoteConfigData, this.remoteService);

  String get name => jsonDecode(remoteConfigData.getString("black_ceramic"))[
          "highlights_covers"][0]["highlightImage"]
      .toString();

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = jsonDecode(
        remoteConfigData.getString("black_ceramic"))["highlights_covers"];
    List<String> url = [];
    for (var i = 0; i < data.length; i++) {
      url.add(Map.from(data[i])["highlightImage"]);
    }
    print(Map.from(data[0])["highlight_cover_name"]);

    return Scaffold(
        body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
            itemCount: url.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    height: 200,
                    width: 200,
                    child: Image.network(url[index]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      ),
    ) //Center(child: Image.network(name)),
        );
  }
}*/



/*
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final int columns;

  GridPainter({required this.columns});

  @override
  void paint(Canvas canvas, Size size) {
    double cellWidth = size.width / columns;

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    for (int i = 1; i < columns; i++) {
      double x = cellWidth * i;
      canvas.drawLine(Offset(x, 0), Offset(x, x / i), paint);
    }

    final borderPaint = Paint()
      ..color = Color.fromARGB(255, 18, 7, 7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRect(
        Rect.fromLTWH(0, 0, cellWidth * columns, cellWidth), borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GridWidget extends StatelessWidget {
  final int columns;

  GridWidget({required this.columns});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(columns: columns),
      size: Size.infinite,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridSelectionPage(),
    );
  }
}

class GridSelectionPage extends StatefulWidget {
  @override
  _GridSelectionPageState createState() => _GridSelectionPageState();
}

class _GridSelectionPageState extends State<GridSelectionPage> {
  int selectedColumns = 2;

  void selectColumns(int columns) {
    setState(() {
      selectedColumns = columns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Example'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGridColumnButton(2),
              _buildGridColumnButton(3),
              _buildGridColumnButton(4),
              _buildGridColumnButton(5),
              _buildGridColumnButton(6),
              _buildGridColumnButton(7),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: GridWidget(columns: selectedColumns),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridColumnButton(int columns) {
    return ElevatedButton(
      onPressed: () => selectColumns(columns),
      child: Text('1x$columns'),
    );
  }
}
*/

//canvas örnek
/*
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridPainter extends CustomPainter {
  final int rows;
  final Paint _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2.0;

  GridPainter({required this.rows});

  @override
  void paint(Canvas canvas, Size size) {
    double cellWidth = size.width / 3;
    double cellHeight = size.height / rows;

    for (int i = 1; i < 3; i++) {
      double x = cellWidth * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), _paint);
    }

    for (int i = 1; i < rows; i++) {
      double y = cellHeight * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GridWidget extends StatelessWidget {
  final int rows;

  GridWidget({required this.rows});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(rows: rows),
      size: Size.infinite,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridSelectionPage(),
    );
  }
}

class GridSelectionPage extends StatefulWidget {
  @override
  _GridSelectionPageState createState() => _GridSelectionPageState();
}

class _GridSelectionPageState extends State<GridSelectionPage> {
  int selectedRows = 3;

  void selectRows(int rows) {
    setState(() {
      selectedRows = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Example'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGridButton(2),
              _buildGridButton(3),
              _buildGridButton(4),
              _buildGridButton(5),
              _buildGridButton(6),
              _buildGridButton(7),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: GridWidget(rows: selectedRows),
          ),
        ],
      ),
    );
  }

  Widget _buildGridButton(int rows) {
    return ElevatedButton(
      onPressed: () => selectRows(rows),
      child: Text('$rows x 3'),
    );
  }
}*/


