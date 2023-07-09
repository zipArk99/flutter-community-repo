import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/models/community.dart';
import 'package:flutter_reddit/services/community_service/controller/community_controller.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_reddit/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  const EditCommunityScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EditCommunityScreenState();
  }
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  late Community community;
  File? bannerImg;
  File? avatarImg;

  @override
  void initState() {
    community = ref.read(communityProvider)!;
    super.initState();
  }

  void pickBanner() async {
    final result = await pickImage();
    if (result != null) {
      setState(
        () {
          bannerImg = File(result.files.single.path!);
        },
      );
    }
  }

  void pickAvatar() async {
    final result = await pickImage();
    if (result != null) {
      setState(
        () {
          avatarImg = File(result.files.single.path!);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.appBarColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Pallete.appBarColor,
          title: const Text("Edit commuinty"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 200,
            child: Stack(
              children: [
                DottedBorder(
                  strokeCap: StrokeCap.round,
                  color: Colors.white,
                  borderType: BorderType.RRect,
                  dashPattern: const [10, 10],
                  strokeWidth: 2,
                  radius: const Radius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      pickBanner();
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: community.banner.isEmpty && bannerImg == null
                          ? const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.white,
                            )
                          : bannerImg != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    bannerImg as File,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 115,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(35),
                      onTap: pickAvatar,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 35,
                        child: community.avatar.isEmpty && avatarImg == null
                            ? Image.asset(
                                'assets/images/reddit_community_logo.png')
                            : avatarImg != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.file(
                                      avatarImg as File,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Container(),
                      )),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
                   
           padding: const EdgeInsets.symmetric(horizontal:20,vertical:20),
          child: ElevatedButton(
            
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              
              minimumSize:Size(double.infinity,50),
            backgroundColor:Pallete.backgroundColor,
            shape: RoundedRectangleBorder(
              
              borderRadius: BorderRadius.circular(50)
            )
            ),
            child: const Text("Update"),
          ),
        ));
  }
}
