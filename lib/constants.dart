import 'package:flutter/material.dart';

const cerulean = Color(0xFF3F51B7);
const heather = Color(0xFFAFBCC4);
const stardust = Color(0xFF9E9E9E);


const dummyJsonUrl = 'https://dummyjson.com';

Widget spacer({double x = 5.0, double y = 5.0}) => SizedBox(height: y, width: x);

Size screen(BuildContext context) => MediaQuery.of(context).size;

extension Helpers on Widget {

	Widget get center => Center(child: this);
	
	Widget align(Alignment value) => Align(alignment: value, child: this);

}