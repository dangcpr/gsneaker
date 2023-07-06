import 'package:flutter/material.dart';
import 'package:gsneaker/constants/colors.dart';
import 'package:gsneaker/controllers/readShoes.dart';
import 'package:gsneaker/models/shoe.dart';
import 'package:provider/provider.dart';

class ourProductScreen extends StatefulWidget {
  const ourProductScreen({super.key});

  @override
  State<ourProductScreen> createState() => _ourProductScreenState();
}

class _ourProductScreenState extends State<ourProductScreen> {


  @override
  Widget build(BuildContext context) {
    context.read<ListShoesProvider>().readJson();
    List<Shoe> _shoes = context.watch<ListShoesProvider>().shoes;

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
            padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 0),
            child: Image.asset('assets/images/nike.png', scale: 9, fit: BoxFit.fill, alignment: Alignment.center),
          ),

          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 0),
            child: Text('Our Products', style: TextStyle(fontFamily: 'RubikBold', fontSize: 24, color: colorProject.Black),),
          ) ,    
                    
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: ListView.builder(
                        itemCount: _shoes.length,
                        itemBuilder: ((context, index) => 
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(int.parse("0xFF${_shoes[index].color.replaceFirst("#", "")}")),
                                    ),
                                    child: RotationTransition(
                                      turns: new AlwaysStoppedAnimation(-15 / 360),
                                      child: Image.network(_shoes[index].image, scale: 1, fit: BoxFit.fill, alignment: Alignment.center),
                                    )
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(_shoes[index].name, style: TextStyle(fontFamily: 'RubikBold', fontSize: 20, color: colorProject.Black),),
                                ),
                              
                                Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Text(_shoes[index].description, style: TextStyle(fontFamily: 'RubikLight', fontSize: 12, color: colorProject.Black),),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget> [
                                      Text("\$" + _shoes[index].price.toString(), style: TextStyle(fontFamily: 'RubikBold', fontSize: 20, color: colorProject.Black, fontWeight: FontWeight.bold),),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          fixedSize: Size(150, 40),
                                          backgroundColor: colorProject.Yellow,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                          )
                                        ),
                                        onPressed: (){
                                          
                                        },
                                        child: Text('ADD TO CART', style: TextStyle(fontFamily: 'RubikBold', fontSize: 14, color: colorProject.Black),),
                                        )
                                    ],
                                  ),
                                )

                              ]
                            )
                          )
                        )
                      )
                    )
                  ),
                  
                ],
              )
            )
          ),
          

        ]
      )
    );
  }
}