import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_reddit/services/community_service/controller/community_controller.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateComumunityScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateCommunityScreenState();
  }
}

class _CreateCommunityScreenState
    extends ConsumerState<CreateComumunityScreen> {
  final _formKey = GlobalKey<FormState>();
  final communityNameController = TextEditingController();
  @override
  void dispose() {
    communityNameController.dispose();
    super.dispose();
  }

  void createCommuinty() {
    
    var name = communityNameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(communityControllerProvider.notifier)
          .createCommunity(name, context);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Please enter name of community !"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading=ref.watch(communityControllerProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        appBar: AppBar(
          backgroundColor: Pallete.appBarColor,
          title: const Text("Create a Community"),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 40,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: communityNameController,
                  maxLength: 15,
                  style: const TextStyle(color: Pallete.textColor1),
                  decoration: InputDecoration(
                    filled: true,
                    hintStyle: const TextStyle(color: Pallete.textColor2),
                    hintText: "r/Community name",
                    labelStyle: const TextStyle(color: Pallete.textColor1),
                    fillColor: Pallete.appBarColor,
                    labelText: "Community name",
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 0),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed:isLoading?null :() {
                    createCommuinty();
                  },
                  child:isLoading?const CircularProgressIndicator():const Text(
                    "Create Community",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
