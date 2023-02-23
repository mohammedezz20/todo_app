

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/Components.dart';
import '../../shared/cubit.dart';
import '../../shared/states.dart';



class Newtask extends StatefulWidget {
  const Newtask({Key? key}) : super(key: key);

  @override
  State<Newtask> createState() => _NewtaskState();
}
var formkey =GlobalKey<FormState>();
var titlecontroler=TextEditingController();
var timecontroler=TextEditingController();
var datecontroler=TextEditingController();
var descriptioncontroler= TextEditingController();
class _NewtaskState extends State<Newtask> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit=  AppCubit.get(context);
        var tasks=AppCubit.get(context).tasks;
                if(tasks.length>0) {
                  return Container(
                          color: HexColor("#ebebeb"),
                          child: Column(
                  children: [
                    Container(height: 80, alignment: Alignment.center,
                      child: Text("${cubit.title[cubit.currentindex]}", style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold
                      ),),),
                   Expanded(

                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => New_Tasks(tasks[index],context),
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
                        Text("No Tasks Yet, Add Some Tasks",
                        style: TextStyle(fontSize: 25),)
                        ],),
                        ),
                        );
                }
        }


    );

  }
}

 Widget New_Tasks(Map model,context){
  return MaterialButton(
    padding: EdgeInsets.zero,
    onPressed: () {  },
    onLongPress: (){showDialog(context: context, builder:(_)=>Dialog(context,model));},
    child: Container(
margin: EdgeInsets.only(left:20,right: 20,top:10),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.only(top:15 ,right: 10,left: 10,bottom: 12),
      child: Row(
        children: [
          IconButton(onPressed: (){
            AppCubit.get(context).updateData(status: 'done', id:model['id'] );
          },
            icon: Icon(Icons.check_circle,size: 30,color: Colors.green,),),
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
                  ),
                ),
                 if (model['description'].isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 3,bottom: 5),
                    child: Text(
                      model['description'],
                      style: TextStyle(fontSize: 20, height: 1.5),
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
    ),
  );
 }


Widget Dialog (context,Map Model)
{
  return AlertDialog(
    content:  SingleChildScrollView(
      child: Container(
width: 500,
        // width: double.infinity,
        color: HexColor("#ffffff"),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(top:15),
                  child: defaulttextFaild(lable: 'Task Title', keyboardtype: TextInputType.text, controller:titlecontroler,
                    // validate: (String val){
                    //   if(val.isEmpty)
                    //   {
                    //     return "Task Title must not be empty";
                    //   }
                    //   else {
                    //     return null;
                    //   }
                    // },
                    validate: (var value) {
                      if (value.isEmpty) {
                        return 'title must not be empty';
                      }

                      return null;
                    },
                    prefixicon: Icons.title ,

                    ispass: false,

                  ),),
                Padding(

                  padding: const EdgeInsets.only(top:15),
                  child: defaulttextFaild(lable: 'Task Description',
                      keyboardtype: TextInputType.multiline,
                      controller:descriptioncontroler,
                      prefixicon: Icons.title ,
                      ispass: false,
                      maxline:3
                  ),),
                Padding(
                  padding: const EdgeInsets.only(top:15),
                  child: defaulttextFaild(lable: 'Task Time',
                      keyboardtype: TextInputType.datetime, controller:timecontroler,
                      // validate: (val){
                      //   if(val=="")
                      //   {
                      //     return "Task Time must not be empty";
                      //   }
                      //   else {
                      //     return null;
                      //   }
                      // },

                      prefixicon: Icons.watch_later_outlined ,

                      ispass: false,

                      ontap: (){

                        showTimePicker(context: context, initialTime: TimeOfDay.now(),)
                            .then((value) => {
                          timecontroler.text= value!.format(context).toString(),
                        });
                      }
                  ),),
                Padding(
                  padding: const EdgeInsets.only(top:15),
                  child: defaulttextFaild(lable: 'Task Date',
                      keyboardtype: TextInputType.datetime, controller:datecontroler,
                      // validate: (val){
                      //   if(val=="")
                      //   {
                      //     return "Task Date must not be empty";
                      //   }
                      //   else {
                      //     return null;
                      //   }
                      // },

                      prefixicon: Icons.date_range ,
                      ispass: false,
                      ontap: (){

                        showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse("2040-01-01"),

                        ).then((value) => {
                          // datecontroler.text=DateFormat.yMMMd().format(value!),


                        });
                      }
                  ),),
                Padding(
                  padding: const EdgeInsets.only(top:15),
                  child: defaultButton(text: 'edit task',
                  function: (){
                    AppCubit.get(context).updateallData(
                      description: descriptioncontroler.text,
                             date: datecontroler.text,
                             time: timecontroler.text,
                               id: Model['id'],
                            title: titlecontroler.text
                    );

                  Navigator.pop(context);
                  timecontroler.text='';
                  titlecontroler.text='';
                  datecontroler.text= '';
                  descriptioncontroler.text='';
                    }
                  ,radius: 5) ),
              ],
            ),
          ),
        )),
    )
  );
}


