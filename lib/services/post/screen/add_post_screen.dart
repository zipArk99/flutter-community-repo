import 'package:flutter/material.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  void navigateToPostTypeScreen(String type,BuildContext contx){
    Routemaster.of(contx).push('/add-post-screen-type/$type');
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding:EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: InkWell(
              onTap: ()=>navigateToPostTypeScreen('Image',context),
              child: Card(
              color: Pallete.appBarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: const Center(
                  child: Icon(
                    Icons.image_outlined,
            
                    size: 60,
                    color:Colors.white,
                  ),
                ),
              ),
            ),
          ),
             InkWell(
            onTap: ()=>navigateToPostTypeScreen('Text',context),
            child: SizedBox(
              height: 120,
              width: 120,
              child: Card(
              color: Pallete.appBarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: const Center(
                  child: Icon(
                    Icons.font_download_outlined,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
             InkWell(
            onTap: ()=>navigateToPostTypeScreen('Link',context),
            child: SizedBox(
              height: 120,
              width: 120,
              child: Card(
              color: Pallete.appBarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: const Center(
                  child: Icon(
                    Icons.link_outlined,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
