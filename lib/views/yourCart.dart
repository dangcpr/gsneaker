import 'package:flutter/material.dart';
import 'package:gsneaker/constants/colors.dart';
import 'package:gsneaker/providers/ShoesProvider.dart';
import 'package:provider/provider.dart';

class yourCartScreen extends StatefulWidget {
  const yourCartScreen({super.key});

  @override
  State<yourCartScreen> createState() => _yourCartScreenState();
}

class _yourCartScreenState extends State<yourCartScreen> {
  @override
  Widget build(BuildContext context) {
    final _listShoesBuyProvider = Provider.of<ListShoesProvider>(context);

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
                      Text('\$' + _listShoesBuyProvider.totalPrice.toStringAsFixed(2).toString() , style: TextStyle(fontFamily: 'RubikBold', fontSize: 24, color: colorProject.Black),)
                    ],
                  ),                  
                ],
              )
            )
          ),

          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 0),
            child: Container(
              child: Column(
                children: <Widget>[
                  
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: _listShoesBuyProvider.listShoesBuy.isEmpty ? Text('Your cart is empty', style: TextStyle(fontFamily: 'RubikLight', fontSize: 14, color: colorProject.Black)): ListView.builder(
                        itemCount: _listShoesBuyProvider.listShoesBuy.length,
                        itemBuilder: ((context, index) => 
                          Container(
                            width: 250,
                            height: 150,
                            child: Row(
                              children: <Widget> [
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Stack(
                                    children: <Widget> [
                                      Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Color(int.parse("0xFF${_listShoesBuyProvider.listShoesBuy[index].color.replaceFirst("#", "")}")),
                                        ), 
                                      ),
                                      
                                      RotationTransition(
                                        turns: new AlwaysStoppedAnimation(-30 / 360),
                                        child: Image.network(_listShoesBuyProvider.listShoesBuy[index].image, width: 90, height: 90, alignment: Alignment.topLeft),
                                      )
                                    ]
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 15, top: 20, bottom: 15),
                                        child: Text(_listShoesBuyProvider.listShoesBuy[index].name, style: TextStyle(fontFamily: 'RubikBold', fontSize: 14, color: colorProject.Black),),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 15, bottom: 15),
                                        child: Text("\$" + _listShoesBuyProvider.listShoesBuy[index].price.toStringAsFixed(2).toString(), style: TextStyle(fontFamily: 'RubikBold', fontSize: 18, color: colorProject.Black),),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () => {
                                                  context.read<ListShoesProvider>().changeQuantityToCartPlus(_listShoesBuyProvider.listShoesBuy[index]),
                                                  context.read<ListShoesProvider>().caculatePrice(),
                                                }, 
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(10, 10),
                                                  backgroundColor: colorProject.GrayLight,
                                                  shape: CircleBorder()
                                                ),                                    
                                                child: Image.asset('assets/images/plus.png', scale: 8, fit: BoxFit.fill, alignment: Alignment.center),
                                              ),

                                              Text(_listShoesBuyProvider.listShoesBuy[index].quantity.toString(), style: TextStyle(fontFamily: 'RubikLight', fontSize: 14, color: colorProject.Black),),

                                              ElevatedButton(
                                                onPressed: () => {
                                                  context.read<ListShoesProvider>().changeQuantityToCartMinus(_listShoesBuyProvider.listShoesBuy[index]),
                                                  context.read<ListShoesProvider>().deleteShoesToCartAuto(),
                                                  context.read<ListShoesProvider>().caculatePrice(),
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(10, 10),
                                                  backgroundColor: colorProject.GrayLight,
                                                  shape: CircleBorder()
                                                ),                                    
                                                child: Image.asset('assets/images/minus.png', scale: 8, fit: BoxFit.fill, alignment: Alignment.center),
                                              ),
                                            ],                            
                                          ),

                                          ElevatedButton(
                                            onPressed: () => {
                                              context.read<ListShoesProvider>().deleteShoesFromCart(_listShoesBuyProvider.listShoesBuy[index]),
                                              context.read<ListShoesProvider>().caculatePrice(),
                                            },
                                            style: ElevatedButton.styleFrom(
                                              //fixedSize: Size(10, 10),
                                              backgroundColor: colorProject.Yellow,
                                              shape: CircleBorder()
                                            ),                                    
                                            child: Image.asset('assets/images/trash.png', scale: 4, alignment: Alignment.center),
                                          ),

                                        ],
                                      )
                                    ],
                                  )
                                )
                              ],
                            )
                          )
                        )
                      )
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
                              
}