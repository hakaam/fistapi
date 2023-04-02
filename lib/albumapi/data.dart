import 'package:flutter/cupertino.dart';

import '../main.dart';
import 'model/datamodel.dart';

class Data extends ChangeNotifier{
 late  DataModel dataModel;

 fetchData(context)async{
   dataModel = await  getData(context);

   notifyListeners();



 }






}