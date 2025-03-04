import 'package:flutter/material.dart';

showLoading(BuildContext context){showDialog(context: context,
    barrierDismissible: false,builder: (context)
{ return AlertDialog(content: Row(children: [Text("loading....."),
  Spacer(),
  CircularProgressIndicator()
]
  ,)
  ,)
;}
);
}

hideLoading(BuildContext context){Navigator.pop(context);}


showMassege(BuildContext context,String mass,
    {String? title,
      String? posButton,
      Function? posButtonClick,
      String? negButton,
      Function? negButtonClick,

    } )
{
  showDialog(context: context,
   builder: (context)
  { return AlertDialog(
      title: title!=null?Text(title,):null,
    content:Text(mass),
    actions: [if(posButton!=null)
      TextButton(onPressed: (){hideLoading(context);
        if(posButtonClick!=null) {
          posButtonClick();
        }},
        child:Text(posButton)),


      
      if(negButton!=null)
        TextButton(onPressed: (){hideLoading(context);
        if(negButtonClick!=null) {
          negButtonClick();
        }},
            child:Text(negButton))],
  )
  ;}
  );}