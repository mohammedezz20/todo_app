import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/cubit.dart';
import '../../shared/states.dart';
import '../Tasks/New_task.dart';

class Donetask extends StatefulWidget {
  const Donetask({Key? key}) : super(key: key);

  @override
  State<Donetask> createState() => _DonetaskState();
}

class _DonetaskState extends State<Donetask> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit=  AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state){
          var tasks=AppCubit.get(context).Done_tasks;
                      if(tasks.length>0) {
                        return   Container(
                          color: HexColor("#ebebeb"),
                          child: Column(
                            children: [
                              Container(height: 80, alignment: Alignment.center,
                                child: Text("${cubit.title[cubit.currentindex]}", style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold
                                ),),),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) => Done_Tasks(tasks[index],context),
                                  itemCount: tasks.length,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      else {
                        return  Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                      Icon(Icons.menu,size: 50,),
                                SizedBox(height: 20,),
                                Text("No Tasks Yet, Add Some Tasksdfgf",
                                      style: TextStyle(fontSize: 25),)
                                    ],),
                          ),
                        );
                      }
        }


    );
  }
}
Widget Done_Tasks(Map model,context){

  return Container(
    margin: EdgeInsets.only(left:20,right: 20,top:10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
    ),
    padding: EdgeInsets.only(top:15 ,right: 10,left: 10,bottom: 12),
    child: Row(
      children: [
        IconButton(onPressed: (){
          AppCubit.get(context).updateData(status: 'new', id:model['id'] );
        },
          icon: Icon(Icons.arrow_back_ios,size: 30,),),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 22,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              if (model['description'].isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 3,bottom: 5),
                  child: Text(
                    model['description'],
                    style: TextStyle(fontSize: 20, height: 1.5,  decoration: TextDecoration.lineThrough,),
                  ),
                ),
              if (model['time'].isNotEmpty&&model['time'].isNotEmpty)
              Row(
                children: [
                  Text(
                    model['time'],
                    style: TextStyle(fontSize: 12, height: 1.5),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    model['date'],
                    style: TextStyle(fontSize: 12, height: 1.5),
                  ),
                ],
              )
            ],
          ),
        ),

        IconButton(onPressed: (){
          AppCubit.get(context).DeleteFromDatabase(id:model['id']);
        },
          icon: Icon(Icons.highlight_remove,size: 30,color: Colors.red,),),
      ],
    ),
  );


}
