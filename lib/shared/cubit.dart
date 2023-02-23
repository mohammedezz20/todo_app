import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/states.dart';

import '../modules/Done_Tasks/Done_Tasks.dart';
import '../modules/Setting/Setting.dart';
import '../modules/Tasks/New_task.dart';

class AppCubit extends Cubit<AppStates>
{
  Map x={'id':1,'title':"adsfsaf"};
  AppCubit() : super(AppIntionalStates());
static AppCubit get(context)=>BlocProvider.of(context);
  List<Map>tasks=[];
  List<Map>Done_tasks=[];
  Database? database;
final pageController=PageController();
  int currentindex=0;
  List <Widget>  screens=[
    Newtask(),
    Donetask(),
  ];
  List <String>title=[
    "New Tasks",
    "Done Tasks",
    "Setting"
  ];
  void changeindex(int index)
  {
    currentindex=index;
    pageController.jumpToPage(index);
    emit(AppChangeBottomNavBArState());
  }
  void CreateDatabase()
  {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database,version){
        print("databasecreate");
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, time TEXT,status TEXT )'
        ).then((value) => {
          print("tabe created")
        }).catchError((error){print(error.toString());});
      },
      onOpen: (database){
        print("open");
        getfromdatabase(database);
        }
        ).then((value) {
      database=value;
      emit(AppCreatedatabase());
      },
    );
  }

   AddToDatabase(
      {
        required String title,
        required String time,
        required String date,
        required String description,
      })async
  {
    await database?.transaction((txn) async{

      txn.rawInsert('INSERT INTO tasks(title, time, date, status, description) '
          'VALUES("$title","$time","$date","new","$description")'
      )
          .then((value)  {
        print('$value inserted successfully');
        emit(AppInsertDatTodatabase());
      getfromdatabase(database);
      }).
      catchError((Error){
        print("error when insert${Error.toString()}");
      });
      return null;
    });
  }
   getfromdatabase(database)
  {
    tasks=[];
    Done_tasks=[];
    emit(AppGetDatFromdatabase());
    database.rawQuery('SELECT * FROM tasks').then((value){

      value.forEach((element) {
       if(element['status']=='new')
         tasks.add(element);
       else
         Done_tasks.add(element);
      });
      emit(AppGetDatFromdatabase());
    });

  }
   void updateData({
  required String status,
     required int id,
})async{
     database?.rawUpdate(
       'UPDATE tasks SET status = ? WHERE id = ?',
       ['$status', id],
     ).then((value)
     {
       getfromdatabase(database);
       emit(AppUpdateDatadatabase());
     });

   }


  void updateallData({
    required int id,
    required String title,
    required String description,
    required String date,
    required String time,
  })async{
    database?.rawUpdate(
      'UPDATE tasks SET time = ?, title = ? ,description = ? , date = ? WHERE  id = ? '  ,
      ['$time' , '$title', '$description', '$date', id],
    ).then((value)
    {
      getfromdatabase(database);
      emit(AppUpdateAllDatadatabase());

    });

  }


   void DeleteFromDatabase(
  {
  required int id,
})async
  {
    database?.rawDelete('DELETE FROM tasks WHERE id = ?', [id]
    ).then((value) {
      getfromdatabase(database);
      emit(AppDeleteDataFromdatabase());
    });
  }
  var fab=Icons.edit;
  bool isbuttomsheetshow=false;
  void Changebottomsheetstate({
  required bool isshow,
required IconData icon
  })
  {
    isbuttomsheetshow=isshow;
    fab=icon;
emit(AppChangeBottomSheetState());
  }
}