import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Map> labels = [
    {
      "name" : "Clear",
      "display": "C",
      "color": Colors.red,
      "bgcolor" : Colors.grey[200],
    },
    {
      "name": "Parenthesis",
      "display" : "( )",
      "color": Colors.green,
      "bgcolor" : Colors.grey[200],
    },
    {
      "name": "Percentage",
      "display": "%",
      "color": Colors.green,
      "bgcolor" : Colors.grey[200],
    },
    {
      "name": "Divide",
      "display": "/",
      "color": Colors.green,
      "bgcolor" : Colors.grey[200],
    },
    {
      "name": "Seven",
      "display": "7",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Eight",
      "display": "8",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Nine",
      "display": "9",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Multiply",
      "display": "x",
      "color": Colors.green,
      "bgcolor" : Colors.grey[200],
    },
    {
      "name": "Four",
      "display": "4",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Five",
      "display": "5",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Six",
      "display": "6",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Subtract",
      "display": "-",
      "color": Colors.green,
      "bgcolor" : Colors.grey[200],
    },
    {
      "name": "One",
      "display": "1",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Two",
      "display": "2",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Three",
      "display": "3",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Add",
      "display": "+",
      "color": Colors.green,
      "bgcolor" : Colors.grey[200],
    },
    {
      "name": "Key",
      "display": "",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Zero",
      "display": "0",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Decimal Point",
      "display": ".",
      "color": Colors.black,
      "bgcolor" : Colors.white,
    },
    {
      "name": "Equal",
      "display": "=",
      "color": Colors.white,
      "bgcolor" : Colors.green,
    }
  ];
  
  String _equation = "";
  String _insertChar = "";
  String _lastChar = "";
  bool _isOpen = false;
  
  // Parentheses
  List<String> _parenthesesStack = [];

  String _push(){
    _parenthesesStack.add(")");
    print(_parenthesesStack);
    return "(";
  }

  String _pop(){
    return _parenthesesStack.removeLast();
  }

  void _perform(int index){
    setState(() {
      switch(labels[index]['name']){
        case "Clear":
          _equation = "";
          _isOpen = false;
          _lastChar = "";
          _parenthesesStack.clear();
          break;
        case "Parenthesis":
          if(_isOpen == false || (_isOpen == true && _lastChar == "OpenPar")){
            _insertChar = _push();
            _lastChar = "OpenPar";
          }else if (_isOpen == true && _lastChar != "Operator"){
            _insertChar = _pop();
            _lastChar = "ClosePar";
          }

          if(_parenthesesStack.isNotEmpty){
            _isOpen = true;
          }else{
            _isOpen = false;
          }
          break;
        case "Equal":
          break;
        case "Percentage":
        case "Divide":
        case "Multiply":
        case "Subtract":
        case "Add":
          if(_lastChar != "OpenPar" && _lastChar != "Operator"  && _lastChar != ""){
            _insertChar = labels[index]['display'];
            _lastChar = "Operator";
          }
          break;
        default:
          _insertChar = labels[index]['display'];
          _lastChar = "Number";
          break;
      }
      _equation += _insertChar;
      _insertChar = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Top container
            // Contains the pressed numbers
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 100, right: 20),
                alignment: Alignment(1, -1),
                child: Text(
                  _equation,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
        
            Divider(
              indent: 10,
              endIndent: 10,
            ),
        
            // Bottom container
            // Contains the buttons
            Expanded(
              flex: 5, // Set bottom column to a larger size than the top one
                child: GridView.builder( // Create grids for the buttons
                  itemCount: labels.length, // Create one grid for each item in "labels" list
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), // Four grid per row
                  itemBuilder: (context, index){ // along with gridview.builder, essential
                    return Stack( // Add stack so that ripple effect of inkwell will display over grids
                      children: [
                        // Modify the grids
                        Container(
                          decoration: BoxDecoration(
                            color: labels[index]['bgcolor'],  // Set circle color based on bgcolor in "labels" list
                            borderRadius: BorderRadius.circular(50) // turn it to a circle
                          ),
                          margin: EdgeInsets.all(2),  // set spacing in between 
                          child: Center(
                            child: Text(
                              labels[index]['display'],
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: labels[index]['color'],
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
        
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _perform(index), // What to do when clicked
                            borderRadius: BorderRadius.circular(50), // Make circle ripple effect 
                          ),
                        )
                        
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}