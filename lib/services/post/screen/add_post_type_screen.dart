import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/models/community.dart';
import 'package:flutter_reddit/services/community_service/controller/community_controller.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils.dart';
import '../controller/post_controller.dart';

class AddPostTypeScreen extends ConsumerStatefulWidget {
  final String type;

  const AddPostTypeScreen({super.key, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AddPostTypeScreenState();
  }
}

class AddPostTypeScreenState extends ConsumerState<AddPostTypeScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _linkController = TextEditingController();
  List<Community> communities = [];
  File? image;
  Community? selectedCommunity;

  void pickPostImage() async {
    final result = await pickImage();
    if (result != null) {
      setState(
        () {
          image = File(result.files.single.path!);
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
    _linkController.dispose();
  }

  void sharePost() {
    if (widget.type == 'Image' &&
        image != null &&
        _titleController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareImagePost(
            context: context,
            title: _titleController.text.trim(),
            selectedCommunity: selectedCommunity ?? communities[0],
            file: image,
          );
    } else if (widget.type == 'Text' && _titleController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareTextPost(
            context: context,
            title: _titleController.text.trim(),
            selectedCommunity: selectedCommunity ?? communities[0],
            description: _descController.text.trim(),
          );
    } else if (widget.type == 'Link' &&
        _titleController.text.isNotEmpty &&
        _linkController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareLinkPost(
            context: context,
            title: _titleController.text.trim(),
            selectedCommunity: selectedCommunity ?? communities[0],
            link: _linkController.text.trim(),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all the fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeImage = widget.type == 'Image';
    final typeText = widget.type == "Text";
    final typeLink = widget.type == "Link";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ' post ${widget.type}',
          style: const TextStyle(color: Pallete.textColor1),
        ),
        backgroundColor: Pallete.appBarColor,
        actions: [
          TextButton(
              onPressed: () {
                sharePost();
              },
              child: const Text(
                'Share',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
      backgroundColor: Pallete.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Pallete.appBarColor,
                  hintStyle: const TextStyle(color: Pallete.textColor2),
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.all(18)),
            ),
            const SizedBox(
              height: 20,
            ),
            if (typeImage)
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
                    pickPostImage();
                  },
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            image as File,
                            fit: BoxFit.fill,
                          ),
                        )
                      : const SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          )),
                ),
              ),
            if (typeText)
              TextField(
                controller: _descController,
                maxLength: 30,
                maxLines: 7,
                decoration: InputDecoration(
                    hintText: 'Enter Description',
                    filled: true,
                    fillColor: Pallete.appBarColor,
                    hintStyle: const TextStyle(color: Pallete.textColor2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    contentPadding: const EdgeInsets.all(18)),
              ),
            if (typeLink)
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Pallete.appBarColor,
                    hintStyle: const TextStyle(color: Pallete.textColor2),
                    hintText: 'Enter Link',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(18)),
              ),
            const SizedBox(
              height: 50,
            ),
              Text('Select Community' ,style: TextStyle(color: Pallete.textColor2),),

            ref.watch(communityStreamProvider).when(
                data: (data) {
                  communities = data;

                  if (data.isEmpty) {
                    return const SizedBox();
                  }

                  return DropdownButton(
                    underline: Container(),
                    style: TextStyle(color:Pallete.textColor1),
                    dropdownColor:Pallete.appBarColor,
                    isExpanded: true,
                    value: selectedCommunity ?? data[0],
                    items: data
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCommunity = val;
                      });
                    },
                  );
                },
                error: (error, stackTrace) {
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(error.toString())));
                  return Text(error.toString());
                },
                loading: () => const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
