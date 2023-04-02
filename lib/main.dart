import 'dart:convert';

import 'package:firstapi/Counter/CounterProvider/counter_provider.dart';
import 'package:firstapi/repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'albumapi/data.dart';
import 'albumapi/model/datamodel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CounterProvider()),



    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final data = Provider.of<Data>(context, listen: false);
    data.fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Network Call'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(data.dataModel.title),
              Text(data.dataModel.id.toString()),
              Text(data.dataModel.userId.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

Future<DataModel> getData(context) async {
  late DataModel dataModel;
  try {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      dataModel = DataModel.fromJson(data);
    } else {
      print('Something went wrong');
    }
  } catch (e) {
    print(e.toString());
  }

  return dataModel;
}
