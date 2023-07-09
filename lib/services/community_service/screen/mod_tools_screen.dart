import 'package:flutter/material.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';



class ModToolsScreen extends ConsumerWidget{
void navigateToEditCommunityScreen(BuildContext contx){
  Routemaster.of(contx).push('/edit-community');
}
  @override
  Widget build(BuildContext contx,WidgetRef ref){
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        centerTitle: true   ,
        title:const Text("Mod Tools"),
         backgroundColor: Pallete.appBarColor,
      ),
      body:Padding(
        padding:const EdgeInsets.symmetric(vertical:5,horizontal:10),
        child: Column(children: [
            ListTile(
            onTap:(){},
            leading:const Icon(Icons.add_moderator ,color:Pallete.textColor1 ),
            title:const Text('Add moderator',style: TextStyle(
              fontSize:Pallete.fontSize1,
              color:Pallete.textColor1
            ),), 
            
          ),
            ListTile(
            onTap:(){
              navigateToEditCommunityScreen(contx);
            },
            leading:const Icon(Icons.edit_sharp ,color:Pallete.textColor1 ),
            title:const Text('Edit community',style: TextStyle(
              fontSize:Pallete.fontSize1,
              color:Pallete.textColor1
            ),), 
            
          )
        ],),
      )
    );
  }
}