import 'package:flutter/material.dart';
import 'package:gsneaker/constants/colors.dart';

class yourCartScreen extends StatefulWidget {
  const yourCartScreen({super.key});

  @override
  State<yourCartScreen> createState() => _yourCartScreenState();
}

class _yourCartScreenState extends State<yourCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 360,
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 20),
            blurRadius: 50,
            color: Colors.grey,
            spreadRadius: 5
          )
        ]
      ),
      child: Stack(
        children: <Widget> [
          Positioned(
            top: -120,
            left: -138,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
                height: 300,
                width: 260,
                margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                decoration: BoxDecoration(
                  color: colorProject.Yellow,
                  borderRadius: new BorderRadius.all(Radius.elliptical(130, 150)),
                ),
                child: Text('     '),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
            child: Image.asset('assets/images/nike.png', scale: 9, fit: BoxFit.fill, alignment: Alignment.center),
          ),          
                    
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Your cart', style: TextStyle(fontFamily: 'RubikBold', fontSize: 24, color: colorProject.Black),),
                      Text('\$3000', style: TextStyle(fontFamily: 'RubikBold', fontSize: 24, color: colorProject.Black),)
                    ],
                  ),
                  Text('Your cart is empty', style: TextStyle(fontFamily: 'RubikLight', fontSize: 14, color: colorProject.Black),)
                ],
              )
            )
          ),
          

        ]
      )
    );
  }
}