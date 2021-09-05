
import 'package:flutter/material.dart';
import 'package:vondemort_interpolation/data/models/dot.dart';
import 'package:vondemort_interpolation/domain/save_data.dart';

class DotCard extends StatelessWidget{
  Dot dot;
  DotCard({required this.dot});

  @override
  Widget build(BuildContext context) {
   return  Padding(
     padding: const EdgeInsets.only(left: 20, right: 20),
     child: Dismissible(
        key: Key(dot.id.toString()),
       child: Container(

         decoration: BoxDecoration(
           color: dot.color == "green" ? Colors.green.shade200: Colors.redAccent.shade200,
           border: Border.all(width: 0.5, color: Colors.grey),
         ),
         child: ListTile(
           title: Row(
             children: [
               Text("id: ${dot.id}"),
               SizedBox(width: 20,),
               Text("x: ${dot.x.toStringAsFixed(1)}"),
               SizedBox(width: 20,),
               Text("y: ${dot.y.toStringAsFixed(1)}"),
               SizedBox(width: 20,),
               dot.color == "green"? Container() : Text("(y calculated!)")
             ],
           )

           //Text(
             //  "id: ${dot.id}, x: ${dot.x.toStringAsFixed(1)}, y: ${dot.y.toStringAsFixed(1)}"),
         ),
       ),
       onDismissed: close,
     ),

   );
  }
  close(_){
    SaveData.controllerInput.add({"remove": dot});
  }

}