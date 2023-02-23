import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.lightBlue,
  Color fontcolor=Colors.white,
  required VoidCallback  function,
  required String text ,
  bool isupper=true,
  double radius=0.0,
  double Fsize=20,
})=>Container(
  width: width,
  child: MaterialButton(
      onPressed: function ,
      child:
      Text((isupper?text.toUpperCase():text),
        style: TextStyle(color: fontcolor,fontSize:Fsize ),)
  ),
  decoration: BoxDecoration(color: background,
      borderRadius: BorderRadius.circular(radius)),
);



// Widget defaulttextFaild({
//   required TextEditingController controller,
//   required TextInputType keyboardtype,
//   ValueChanged? onsubmit=null,
//   ValueChanged? onChange=null,
//   Function? ontap=null,
//   FormFieldValidator? validate=null,
//   VoidCallback? suffixpressed=null,
//   required String lable ,
//   IconData? prefixicon,
//   IconData? suffixicon,
//   double fontsize=20.0,
//   double height=45,
//   double weight=double.infinity,
//   bool ispass=true,
//   Color  piconcolor =  const Color(0xFF212121),
//   double radius=5.0
// })=> Container(
//   height:height ,
//   width: weight,
// alignment: Alignment.center,
//   decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
//     color: Colors.white,),
//   child:   TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//           hintText: lable,
//           prefixIcon: prefixicon!=null?Icon(prefixicon,color: piconcolor,):null,
//           suffixIcon: suffixicon!=null?IconButton(onPressed: (){suffixpressed!();}, icon: Icon(suffixicon)):null,
//           // border:const OutlineInputBorder(),
//           border: InputBorder.none,
//           prefix:SizedBox(width: 15,)
//       ),
//       keyboardType:keyboardtype,
//       obscureText: ispass,
//       onFieldSubmitted: onsubmit,
//       onChanged:onChange,
//       validator:  validate,
//       style: TextStyle(fontSize:fontsize,
//         fontWeight: FontWeight.bold,
//       ),
//        onTap: (){ontap!();},
//   ),
// );
Widget defaulttextFaild({
  required TextEditingController controller,
  required TextInputType keyboardtype,
  ValueChanged? onsubmit=null,
  ValueChanged? onChange=null,
  FormFieldValidator? validate=null,
  VoidCallback? suffixpressed=null,
  required String lable ,
  IconData? prefixicon,
  IconData? suffixicon,
  bool ispass=true,
  Function? ontap=null,
  bool isclick=true,
  int maxline=1,
})=> TextFormField(
  controller: controller,
  obscureText: ispass,
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon: prefixicon!=null?Icon(prefixicon):null,
    suffixIcon: suffixicon!=null?IconButton(onPressed: suffixpressed, icon: Icon(suffixicon)):null,
    border:const OutlineInputBorder(), ),
  keyboardType:keyboardtype,
  onFieldSubmitted: onsubmit,
  onChanged:onChange,
  validator:  validate,
  enabled: isclick,
  maxLines: maxline,
  onTap: (){ontap!();},
);
