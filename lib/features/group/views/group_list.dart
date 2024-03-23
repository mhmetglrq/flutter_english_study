import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/extensions/context_extension.dart';
import 'package:flutter_english_study/config/items/app_colors.dart';
import 'package:flutter_english_study/config/routes/route_names.dart';
import 'package:flutter_english_study/config/utility/enum/svg_enum.dart';
import 'package:flutter_english_study/features/home/repository/home_repository.dart';
import 'package:flutter_english_study/features/home/views/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupList extends ConsumerWidget {
  const GroupList({super.key, required this.area});
  final String area;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group List'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ref
                  .watch(area == "myGroups"
                      ? getMyGroupsFutureProvider
                      : getAllGroupsFutureProvider)
                  .when(
                    data: (groups) {
                      return Expanded(
                        child: Padding(
                          padding: context.paddingAllDefault,
                          child: ListView.builder(
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              final group = groups[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                surfaceTintColor: AppColors.lightBlue,
                                color: AppColors.lightBlue,
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  splashColor: AppColors.lightPurple,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: context.dynamicWidth(0.05),
                                    vertical: context.dynamicHeight(0.005),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.lightPurple,
                                    child: Text(
                                      "${group.members?.length}",
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: context.dynamicHeight(0.02),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "${group.title}",
                                    style:
                                        context.textTheme.labelMedium?.copyWith(
                                      color: AppColors.lightPurple,
                                      fontSize: context.dynamicHeight(0.022),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${group.description}",
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.lightPurple,
                                      fontSize: context.dynamicHeight(0.02),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    child: SvgPicture.asset(
                                        SvgConstants.more.getSvg),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                      );
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Home(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text("Error: $error"),
                  ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: context.paddingAllDefault,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleWidget(title: "Create Group"),
                  Text(
                    "Create a group to study together",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.lightPurple,
                      fontSize: context.dynamicHeight(0.02),
                    ),
                  ),
                  Padding(
                    padding: context.paddingVerticalLow,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.createGroup);
                      },
                      minWidth: context.dynamicWidth(1),
                      color: AppColors.lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      ),
                      child: Padding(
                        padding: context.paddingVerticalLow,
                        child: Text(
                          "Create Group",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: context.dynamicHeight(0.02),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
