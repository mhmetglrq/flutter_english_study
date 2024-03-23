import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/extensions/context_extension.dart';
import 'package:flutter_english_study/core/models/user_model.dart';
import 'package:flutter_english_study/features/group/controller/group_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/items/app_colors.dart';
import '../../../core/models/group_model.dart';

class CreateGroup extends ConsumerStatefulWidget {
  const CreateGroup({super.key});

  @override
  ConsumerState<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends ConsumerState<CreateGroup> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<TextEditingController> _memberControllers = [];
  List<String>? memberUids = [];
  final List<UserModel?> _members = [];
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (var controller in _memberControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              Padding(
                padding: context.paddingVerticalLow,
                child: TextFormField(
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.lightPurple,
                  ),
                  cursorColor: AppColors.lightPurple,
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Group Name",
                    hintStyle: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.lightPurple,
                    ),
                    filled: true,
                    fillColor: AppColors.lightBlue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: context.paddingVerticalLow,
                child: TextFormField(
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.lightPurple,
                  ),
                  cursorColor: AppColors.lightPurple,
                  controller: _descriptionController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.lightPurple,
                    ),
                    filled: true,
                    fillColor: AppColors.lightBlue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < _memberControllers.length; i++)
                Padding(
                  padding: context.paddingVerticalLow,
                  child: TextFormField(
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.lightPurple,
                    ),
                    cursorColor: AppColors.lightPurple,
                    controller: _memberControllers[i],
                    onFieldSubmitted: (value) async {
                      await ref
                          .read(groupControllerProvider)
                          .getUser(uid: value)
                          .then(
                            (value) => {
                              {
                                setState(() {
                                  _members.add(value);
                                  memberUids?.add(value.uid!);
                                })
                              }
                            },
                          );
                    },
                    decoration: InputDecoration(
                      hintText: "Member Code",
                      hintStyle: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.lightPurple,
                      ),
                      filled: true,
                      fillColor: AppColors.lightBlue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          _memberControllers[i].clear();
                          if (_memberControllers[i].text.isEmpty) {
                            setState(() {
                              _memberControllers.removeAt(i);
                              memberUids?.removeAt(i);
                            });
                          } else {
                            UserModel userModel = await ref
                                .read(groupControllerProvider)
                                .getUser(uid: _memberControllers[i].text);
                            setState(() {
                              _memberControllers.removeAt(i);
                              _members.remove(userModel);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.lightPurple,
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: context.paddingVerticalDefault,
                child: const Divider(
                  color: AppColors.lightBlue,
                ),
              ),
              Row(
                children: [
                  FutureBuilder<UserModel>(
                      future:
                          ref.read(groupControllerProvider).getCurrentUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final model = snapshot.data;
                          return Padding(
                            padding: context.paddingRightDefault,
                            child: CircleAvatar(
                              radius: context.dynamicWidth(0.1),
                              backgroundColor: AppColors.lightBlue,
                              child: Center(
                                child: Text(
                                  "${model?.email?[0].toUpperCase()}",
                                  style: context.textTheme.headlineMedium
                                      ?.copyWith(color: AppColors.lightPurple),
                                ),
                              ),
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          return const SizedBox();
                        }
                      }),
                  for (int i = 0; i < _members.length; i++)
                    Padding(
                      padding: context.paddingRightDefault,
                      child: CircleAvatar(
                        radius: context.dynamicWidth(0.1),
                        backgroundColor: AppColors.lightBlue,
                        child: Center(
                          child: Text(
                            "${_members[i]!.email?[0].toUpperCase()}",
                            style: context.textTheme.headlineMedium
                                ?.copyWith(color: AppColors.lightPurple),
                          ),
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _memberControllers.add(TextEditingController());
                      });
                    },
                    child: CircleAvatar(
                      radius: context.dynamicWidth(0.1),
                      backgroundColor: AppColors.lightBlue,
                      child: Center(
                        child: Icon(
                          Icons.add_outlined,
                          color: AppColors.lightPurple,
                          size: context.dynamicHeight(0.05),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: context.paddingVerticalHigh,
                child: MaterialButton(
                  onPressed: () async {
                    await ref
                        .read(groupControllerProvider)
                        .createGroup(
                          GroupModel(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            members: memberUids,
                          ),
                        )
                        .whenComplete(() => Navigator.pop(context));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minWidth: context.dynamicWidth(1),
                  color: AppColors.lightPurple,
                  child: Text(
                    "Create Group",
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: context.dynamicHeight(
                        0.02,
                      ),
                      color: AppColors.lightBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
