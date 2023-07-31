import "package:flutter/material.dart";
import "package:flutter_reddit/services/community_service/controller/community_controller.dart";
import "package:flutter_reddit/theme/pallete.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:routemaster/routemaster.dart";

class CommunitySearch extends SearchDelegate{
   final WidgetRef _ref;

   CommunitySearch({required WidgetRef ref}):_ref=ref;

  @override
 // ThemeData appBarTheme(BuildContext context) {
 //   // ignore: deprecated_member_use
 //   return ThemeData(
 //     textTheme:TextTheme(headline1: TextStyle(
 //       color: Colors.amber
 //     )),
 //     inputDecorationTheme:const InputDecorationTheme(
 //       hintStyle:TextStyle(color:Colors.white),
 //       border: InputBorder.none,
 //       prefixStyle:TextStyle(color: Colors.white),
 //       suffixStyle: TextStyle(color: Colors.white),
 //       
 //  
 //     ),
 //     appBarTheme: AppBarTheme(backgroundColor:Pallete.appBarColor),
 //   );
 // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      
      IconButton(onPressed: (){
        query="";
      }, icon:const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return  IconButton(onPressed: (){
    Routemaster.of(context).pop();
    }, icon:const Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
    //_ref.watch(communitySerachStreamProvider(query)).when(data: data, error: error, loading: loading)
  }

}