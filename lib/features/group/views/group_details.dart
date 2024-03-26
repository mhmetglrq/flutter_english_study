import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/extensions/context_extension.dart';
import 'package:flutter_english_study/config/items/app_colors.dart';
import 'package:flutter_english_study/core/models/user_model.dart';
import 'package:flutter_english_study/features/group/controller/group_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class GroupDetail extends ConsumerStatefulWidget {
  const GroupDetail({super.key, required this.groupUid});
  final String groupUid;

  @override
  ConsumerState<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends ConsumerState<GroupDetail> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<TextEditingController> _memberControllers = [];
  String currentUserUid = "";
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
  void initState() {
    super.initState();
    ref.read(groupControllerProvider).getCurrentUser().then((value) {
      currentUserUid = value.uid ?? "";
    });
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
              ref.watch(getGroupFutureProvider(widget.groupUid)).when(
                    data: (group) {
                      _titleController.text = group.title!;
                      _descriptionController.text = group.description!;

                      return Column(
                        children: [
                          Padding(
                            padding: context.paddingVerticalLow,
                            child: TextFormField(
                              enabled: currentUserUid == group.creatorUid
                                  ? true
                                  : false,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.lightPurple,
                              ),
                              cursorColor: AppColors.lightPurple,
                              controller: _titleController,
                              decoration: InputDecoration(
                                hintText: "Group Name",
                                hintStyle:
                                    context.textTheme.titleMedium?.copyWith(
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
                              enabled: currentUserUid == group.creatorUid
                                  ? true
                                  : false,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.lightPurple,
                              ),
                              cursorColor: AppColors.lightPurple,
                              controller: _descriptionController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: "Description",
                                hintStyle:
                                    context.textTheme.titleMedium?.copyWith(
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
                            padding: context.paddingVerticalDefault,
                            child: const Divider(
                              color: AppColors.lightBlue,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < (group.members?.length ?? [].length);
                                      i++)
                                    FutureBuilder<UserModel>(
                                      future: ref
                                          .read(groupControllerProvider)
                                          .getUser(
                                              uid: group.members?[i] ?? ""),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final user = snapshot.data;
                                          return Padding(
                                            padding:
                                                context.paddingRightDefault,
                                            child: CircleAvatar(
                                              radius: context.dynamicWidth(0.1),
                                              backgroundColor:
                                                  AppColors.lightBlue,
                                              child: Center(
                                                child: Text(
                                                  "${user?.email?[0].toUpperCase()}",
                                                  style: context
                                                      .textTheme.headlineMedium
                                                      ?.copyWith(
                                                          color: AppColors
                                                              .lightPurple),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  GestureDetector(
                                    onTap: () async {
                                      await Share.share(
                                        'Join my group ${group.title} on Flutter English Study App. Group Code: ${group.uid}',
                                        subject: 'Group Invitation',
                                        sharePositionOrigin: Rect.fromCenter(
                                          center: Offset.zero,
                                          width: 0,
                                          height: 0,
                                        ),
                                      );
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
                            ),
                          ),
                          currentUserUid == group.creatorUid
                              ? Padding(
                                  padding: context.paddingVerticalHigh,
                                  child: MaterialButton(
                                    onPressed: () async {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minWidth: context.dynamicWidth(1),
                                    color: AppColors.lightPurple,
                                    child: Text(
                                      "Create Group",
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                        fontSize: context.dynamicHeight(
                                          0.02,
                                        ),
                                        color: AppColors.lightBlue,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text(
                      error.toString(),
                      style: context.textTheme.headlineMedium
                          ?.copyWith(color: AppColors.lightPurple),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
