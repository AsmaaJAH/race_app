// determine the screen dimensions, in order to use the two variables "kScreenWidth" and "kScreenHeight" in everywhere:
import 'package:flutter/material.dart';
//declaration & dummy initialization:
var kScreenWidth=400.0;
var kScreenHeight=800.0;

void knowScreenWidth(BuildContext context){
   kScreenWidth = MediaQuery.of(context).size.width;
}
void knowScreenHeight(BuildContext context){
 kScreenHeight = MediaQuery.of(context).size.height;
}
