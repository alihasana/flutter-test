import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:serial_number/serial_number.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _serialNumber = 'Unknown';
  String _imei = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String imei;
    List imeiList;
    imei = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);
    imeiList = await ImeiPlugin.getImeiMulti(
        shouldShowRequestPermissionRationale: true);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on $androidInfo');
    print('id ${androidInfo.id}');
    print('androidId ${androidInfo.androidId}');
    print('isPhysicalDevice ${androidInfo.isPhysicalDevice}');
    print('type ${androidInfo.type}');
    print('tags ${androidInfo.tags}');
    print('product ${androidInfo.product}');
    print('version ${androidInfo.version}');
    print('board ${androidInfo.board}');
    print('bootloader ${androidInfo.bootloader}');
    print('brand ${androidInfo.brand}');
    print('device ${androidInfo.device}');
    print('display ${androidInfo.display}');
    print('fingerprint ${androidInfo.fingerprint}');
    print('hardware ${androidInfo.hardware}');
    print('host ${androidInfo.host}');
    print('manufacturer ${androidInfo.manufacturer}');
    imeiList.forEach((element) => print(element));
    if (!mounted) return;
    print('imei: $imei');
    String serialNumber;
    // Platform messages may fail, so we use a try/catch PlatformException.

    serialNumber = await SerialNumber.serialNumber;

    print('serialNumber on $serialNumber');
    setState(() {
      _imei = imei;
      _serialNumber = serialNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(_imei), Text(_serialNumber)],
          ),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
        ));
  }
}
