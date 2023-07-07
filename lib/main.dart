import 'package:flutter/material.dart';
import 'package:gsneaker/providers/ShoesProvider.dart';
import 'package:gsneaker/views/ourProducts.dart';
import 'package:gsneaker/views/yourCart.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider (
      providers: [
        ChangeNotifierProvider(create: (_) => ListShoesProvider()),
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
      title: 'G-Sneaker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'G-Sneaker'),
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
    final screenWidth = MediaQuery.of(context).size.width;
    late final Widget listScreen;
    if (screenWidth < 800) {
      listScreen = ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: <Widget>[
            Padding ( 
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: ourProductScreen(),
            ),
            Padding ( 
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: yourCartScreen(),
            )
          ],
        )
      );
    }
    else {
      listScreen = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ourProductScreen(),
          yourCartScreen(),
        ],
      );
    }
    return Scaffold(
      /*
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(fontFamily: "RubikSemiBold"),),
      ),
      */
      body: Center(
        child: listScreen,
      ),
    );
  }
}
