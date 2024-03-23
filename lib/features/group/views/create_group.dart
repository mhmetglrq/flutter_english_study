import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/extensions/context_extension.dart';

import '../../../config/items/app_colors.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          children: [
            TextFormField(
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.whiteColor,
              ),
              cursorColor: AppColors.whiteColor,
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Group Name",
                hintStyle: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.5),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.dynamicWidth(0.05),
                ),
                filled: true,
                fillColor: AppColors.lightPurple,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: context.dynamicHeight(0.02)),
            TextFormField(
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.whiteColor,
              ),
              cursorColor: AppColors.whiteColor,
              controller: _titleController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.5),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.dynamicWidth(0.05),
                ),
                filled: true,
                fillColor: AppColors.lightPurple,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
