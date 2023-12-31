import 'package:flutter/material.dart';
import 'package:gsneaker/constants/colors.dart';
import 'package:gsneaker/providers/ShoesProvider.dart';
import 'package:provider/provider.dart';

class ourProductScreen extends StatefulWidget {
  const ourProductScreen({super.key});

  @override
  State<ourProductScreen> createState() => _ourProductScreenState();
}

class _ourProductScreenState extends State<ourProductScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ListShoesProvider>().readJson(context);
  }
  @override
  Widget build(BuildContext context) {
    final shoesProvider = Provider.of<ListShoesProvider>(context);

    return UnconstrainedBox(
      child: Container(
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
              child: SelectableText('Our Products', style: TextStyle(fontFamily: 'RubikBold', fontSize: 24, color: colorProject.Black),),
            ) ,    
                      
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: shoesProvider.shoes.length == 0 ? SelectableText('Our Products is empty', style: TextStyle(fontFamily: 'RubikLight', fontSize: 14, color: colorProject.Black)): ListView.builder(
                          itemCount: shoesProvider.shoes.length,
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
                                        color: Color(int.parse("0xFF${shoesProvider.shoes[index].color.replaceFirst("#", "")}")),
                                      ),
                                      child: RotationTransition(
                                        turns: new AlwaysStoppedAnimation(-15 / 360),
                                        child: Image.network(shoesProvider.shoes[index].image, scale: 1, fit: BoxFit.fill, alignment: Alignment.center),
                                      )
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: SelectableText(shoesProvider.shoes[index].name, style: TextStyle(fontFamily: 'RubikBold', fontSize: 20, color: colorProject.Black),),
                                  ),
                                
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: SelectableText(shoesProvider.shoes[index].description, style: TextStyle(fontFamily: 'RubikLight', fontSize: 12, color: colorProject.Black),),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget> [
                                        SelectableText("\$" + shoesProvider.shoes[index].price.toStringAsFixed(2).toString(), style: TextStyle(fontFamily: 'RubikBold', fontSize: 20, color: colorProject.Black, fontWeight: FontWeight.bold),),

                                        context.read<ListShoesProvider>().listShoesBuy.indexWhere((item) => item.productID == shoesProvider.shoes[index].productID) == -1 ? 
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              fixedSize: Size(150, 45),
                                              backgroundColor: colorProject.Yellow,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)
                                              )
                                            ),
                                            onPressed: () {
                                              context.read<ListShoesProvider>().addShoesToCart(shoesProvider.shoes[index]);
                                              context.read<ListShoesProvider>().caculatePrice();
                                            },
                                            child: Text('ADD TO CART', style: TextStyle(fontFamily: 'RubikBold', fontSize: 14, color: colorProject.Black),),
                                          ) :
                                          TextButton(
                                            onPressed: null,
                                            style: TextButton.styleFrom(
                                              fixedSize: Size(45, 45),
                                              backgroundColor: colorProject.Yellow,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(80)
                                              )
                                            ),
                                            child: Image.asset('assets/images/check.png', scale: 3, fit: BoxFit.fill, alignment: Alignment.center),
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
      )
    );
  }
  
}