//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:hexcolor/hexcolor.dart';
//
//
//
//
//
// import '../shared/Components.dart';
// var key =GlobalKey<ScaffoldState>();
// var formkey =GlobalKey<FormState>();
// var titlecontroler=TextEditingController();
// var timecontroler=TextEditingController();
// var datecontroler=TextEditingController();
// var descriptioncontroler= TextEditingController();
// class HoleLayout extends StatelessWidget {
//   const HoleLayout({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//       create: (BuildContext context)=>AppCubit()..CreateDatabase(),
//       child: BlocConsumer<AppCubit,AppStates>(
//         listener: (context , AppStates state){
//           if(state is AppInsertDatTodatabase)
//             {
//               Navigator.pop(context);
//               timecontroler.text='';
//               titlecontroler.text='';
//               datecontroler.text= '';
//               descriptioncontroler.text='';
//
//             }
//         },
//         builder: (context , AppStates state)
//         { AppCubit cubit=  AppCubit.get(context);
//           return SafeArea(
//             child: Scaffold(
//                 key: key,
//
//                 // bottomNavigationBar: BottomNavigationBar(
//                 //   type: BottomNavigationBarType.fixed,
//                 //   showSelectedLabels: true,
//                 //   currentIndex:   cubit.currentindex,
//                 //   onTap: (index) {
//                 //
//                 //       cubit.changeindex(index);
//                 //
//                 //   },
//                 //   items: const [
//                 //     BottomNavigationBarItem(icon: Icon(Icons.task),
//                 //         label: "Tasks"),
//                 //     BottomNavigationBarItem(icon: Icon(Icons.done_all),
//                 //         label: "Done"),
//                 //
//                 //   ],
//                 // ),
//                 bottomNavigationBar: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//                   child: GNav(
// duration: Duration(milliseconds: 800),
//                     activeColor: Colors.black,
//                     color: Colors.black,
//                     tabBorderRadius: 10,
//                     tabBackgroundColor:Colors.blue.shade100,
//                     gap: 10,
//                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
//                     onTabChange: (index){cubit.changeindex(index);},
//                     tabs: [
//                       GButton(icon: Icons.task,text: "New Task",),
//                       GButton(icon: Icons.done_all,text: "Done Task",),
//                       GButton(icon: Icons.settings,text: "Setting",),
//                     ],
//                   ),
//                 ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   if(cubit.isbuttomsheetshow) {
//                     if (formkey.currentState!.validate()) {
//                       cubit.AddToDatabase(
//                           title: titlecontroler.text,
//                           time: timecontroler.text,
//                           date: datecontroler.text,
//                           description: descriptioncontroler.text);
//
//                       print(cubit.tasks);
//                     }
//                   }
//
//                   else {
//                     descriptioncontroler.text = '';
//                     key.currentState!.showBottomSheet((context) =>
//                         createbuttomsheet(context))
//                         .closed.then((value) {
//                       cubit.Changebottomsheetstate(
//                           isshow: false, icon: Icons.edit);
//
//                     });
//                     cubit.Changebottomsheetstate(
//                         isshow: true, icon: Icons.add);
//                   }
//                 }
//                 , child: Icon(cubit.fab),
//               ),
//
//               body: Container(
//                   color: HexColor("#ebebeb"),
//                   child: Column(
//                     children: [
//                       Container(height: 80, alignment: Alignment.center,
//                         child: Text("${cubit.title[cubit.currentindex]}", style: const TextStyle(
//                             fontSize: 25, fontWeight: FontWeight.bold
//                         ),),),
//                       cubit.screens[cubit.currentindex],
//                     ],
//                   ),
//                 ),
//
//             ),
//           );
//
//         }
//       ),
//     );
//   }
// }
//
// Widget createbuttomsheet(context){
//   return  Container(
//
//       width: double.infinity,
//       color: HexColor("#ffffff"),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: formkey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 15,),
//               Padding(
//                 padding: const EdgeInsets.only(top:15),
//                 child: defaulttextFaild(lable: 'Task Title', keyboardtype: TextInputType.text, controller:titlecontroler,
//                   // validate: (String val){
//                   //   if(val.isEmpty)
//                   //   {
//                   //     return "Task Title must not be empty";
//                   //   }
//                   //   else {
//                   //     return null;
//                   //   }
//                   // },
//                   validate: (var value) {
//                     if (value.isEmpty) {
//                       return 'title must not be empty';
//                     }
//
//                     return null;
//                   },
//                   prefixicon: Icons.title ,
//
//                   ispass: false,
//
//                 ),),
//               Padding(
//
//                 padding: const EdgeInsets.only(top:15),
//                 child: defaulttextFaild(lable: 'Task Description',
//                     keyboardtype: TextInputType.multiline,
//                     controller:descriptioncontroler,
//                     prefixicon: Icons.title ,
//                     ispass: false,
//                     maxline:3
//                 ),),
//               Padding(
//                 padding: const EdgeInsets.only(top:15),
//                 child: defaulttextFaild(lable: 'Task Time',
//                     keyboardtype: TextInputType.datetime, controller:timecontroler,
//                     // validate: (val){
//                     //   if(val=="")
//                     //   {
//                     //     return "Task Time must not be empty";
//                     //   }
//                     //   else {
//                     //     return null;
//                     //   }
//                     // },
//
//                     prefixicon: Icons.watch_later_outlined ,
//
//                     ispass: false,
//
//                     ontap: (){
//
//                       showTimePicker(context: context, initialTime: TimeOfDay.now(),)
//                           .then((value) => {
//                         timecontroler.text= value!.format(context).toString(),
//                       });
//                     }
//                 ),),
//               Padding(
//                 padding: const EdgeInsets.only(top:15),
//                 child: defaulttextFaild(lable: 'Task Date',
//                     keyboardtype: TextInputType.datetime, controller:datecontroler,
//                     // validate: (val){
//                     //   if(val=="")
//                     //   {
//                     //     return "Task Date must not be empty";
//                     //   }
//                     //   else {
//                     //     return null;
//                     //   }
//                     // },
//
//                     prefixicon: Icons.date_range ,
//                     ispass: false,
//                     ontap: (){
//
//                       showDatePicker(context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime.parse("2040-01-01"),
//
//                       ).then((value) => {
//                         datecontroler.text=DateFormat.yMMMd().format(value!),
//
//                       });
//                     }
//                 ),),
//             ],
//           ),
//         ),
//       ));
// }