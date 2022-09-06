import 'package:flutter/material.dart';


class Barriers extends StatelessWidget{
  final double size;

  const Barriers({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: 50,
        height: size,
        color: Colors.white,
    );
  }

}

