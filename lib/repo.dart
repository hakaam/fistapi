import 'package:flutter/cupertino.dart';

class Repo extends ChangeNotifier{

  String value='Hello World';
  void changeValue(String newValue){

    value =newValue;



  }


}