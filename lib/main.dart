import 'package:flutter/material.dart';
import 'package:gsneaker/controllers/readShoes.dart';
import 'package:gsneaker/providers/listShoesBuyProvider.dart';
import 'package:gsneaker/views/ourProducts.dart';
import 'package:gsneaker/views/yourCart.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider (
      providers: [
        ChangeNotifierProvider(create: (_) => ListShoesProvider()),
        ChangeNotifierProvider(create: (_) => ListShoesBuyProvider()),
      ],
      child: const MyApp(),
    ) 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Our Products',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Our Products'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(fontFamily: "RubikSemiBold"),),
      ),
      */
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ourProductScreen(),
            yourCartScreen(),
          ],
        ),
      ),
    );
  }
}
