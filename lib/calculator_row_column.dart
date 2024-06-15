import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalculatorRowColumn extends StatelessWidget {
  CalculatorRowColumn({super.key}): _darkGreyBackgroundColor = Color.fromARGB(255, 51, 51, 51);
  final Color _darkGreyBackgroundColor;

  final _buttonSpecification = [
    ['AC', Icons.exposure, '%', '➗'],
    [7, 8, 9, 'x'],
    [4, 5, 6, '-'],
    [1, 2, 3, '+'],
    [0, '.', '=']
  ];

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return Container( 
      color: Colors.black, // TODO(you): Fix this color
      width: 550,
      height: 750,
      child: Column(
          children: [
            Container(
              height: 40,
            ),
            _makeNumberDisplay(),
            _makeInputUIFromData(),
          ],
        ),
    );
  }

  _makeNumberDisplay(){
    return Align(
      alignment: Alignment.centerRight, 
      child: Padding( 
        padding: EdgeInsets.only(right: 35.0, bottom: 15.0),
        child: Semantics(
          label: "User Input",
          child: Text('42', style: TextStyle(fontSize: 74, fontWeight: FontWeight.w800, color: Colors.white))
        )
        
      )
    );
  }

  _makeInputUIFromData(){
    return Column(
        children: _makeButtonRows()
      );
  }

  _makeButtonRows(){
    return _buttonSpecification.map((row) {
      return Row(
        children: row.map((entry) {
          return _makeButtonFromSpecificationEntry(entry);
        }).toList(),
      );
    }).toList();
  }

  Widget _makeButtonFromSpecificationEntry(entry){
    final rightColumnSymbols = ['➗', 'x', '-', '+', '='];

    //Default stylings for buttons (change conditionally based on button type)
    FontWeight fontweight = FontWeight.w900;
    double fontSize = 40.0;
    Color color = Colors.white;
    Color backgroundColor = _darkGreyBackgroundColor;

    if (entry is int){ 
      if(entry == 0){
        return _makeExpandedButton(
        _makeWideButton(
            child: Text(entry.toString(), style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w900
            ),), 
            backgroundColor: _darkGreyBackgroundColor
          ), 2);
      }

    } else if ( entry is IconData ){ 
      return _makeExpandedButton(
        _makeCircularButton
          (child: Icon(entry, color: Colors.black, size: 40), 
          backgroundColor: Colors.grey,
          elementContent: 'Division'
        ), 1);

    } else if ( entry is String ){ // TODO(you): handle case where the entry is a String
      if (rightColumnSymbols.contains(entry)){
        backgroundColor = Colors.orange;
        if(entry == '➗'){
          fontweight = FontWeight.w100;
        }
      }
      else if (entry != "."){
        color = Colors.black;
        backgroundColor = Colors.grey;
      }
    } else { // This should never be used, but makes sure we always return a widget, even if our _buttonSpecification includes something we didn't anticipate
      return const Placeholder();
    }
    return _makeExpandedButton(
        _makeCircularButton(
            child: Text(entry.toString(), style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontweight
            ),), 
            backgroundColor: backgroundColor,
            elementContent: entry.toString()
          ), 1);
  }


  _makeExpandedButton(ElevatedButton button, int flex){
    return Expanded(
      flex: flex,
      child: Container(
        child: button,
        height: 100,
        width: 100,
        margin: EdgeInsets.only(bottom: 10.0),
      )
    );
  }

  _makeCircularButton({required Widget child, required Color backgroundColor, required elementContent}){
     return ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: const CircleBorder() 
            ),
            child: Padding(
              child: Semantics(
                child: child,
                label: '${elementContent} button',
              ),
              padding: EdgeInsets.all(5.0),
            ), 
          );
  }

  _makeWideButton({required Widget child, required Color backgroundColor}){
    return ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: const StadiumBorder() 
            ),
            child: child, 
          );
  }



}