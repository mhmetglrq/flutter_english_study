import 'package:flutter/material.dart';
import 'package:flutter_english_study/config/extensions/context_extension.dart';
import 'package:flutter_english_study/config/items/app_colors.dart';
import 'package:flutter_english_study/config/routes/route_names.dart';
import 'package:flutter_english_study/config/utility/enum/svg_enum.dart';
import 'package:flutter_english_study/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: context.paddingVerticalDefault,
                child: Material(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: context.dynamicWidth(1),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: context.paddingAllDefault,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.groupList,
                                arguments: {"area": "allGroups"});
                          },
                          child: Column(
                            children: [
                              Text(
                                "Total Groups",
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.lightPurple,
                                ),
                              ),
                              ref.watch(getAllGroupsFutureProvider).when(
                                    data: (value) {
                                      return Row(
                                        children: [
                                          Text(
                                            value.length.toString(),
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                              color: AppColors.lightPurple,
                                              fontSize:
                                                  context.dynamicHeight(0.05),
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            SvgConstants.group.getSvg,
                                            height:
                                                context.dynamicHeight(0.035),
                                          ),
                                        ],
                                      );
                                    },
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) => Text(
                                      error.toString(),
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                        color: AppColors.lightPurple,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.groupList,
                              arguments: {"area": "myGroups"},
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                "My Groups",
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.lightPurple,
                                ),
                              ),
                              ref.watch(getMyGroupsFutureProvider).when(
                                    data: (value) {
                                      return Row(
                                        children: [
                                          Text(
                                            value.length.toString(),
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                              color: AppColors.lightPurple,
                                              fontSize:
                                                  context.dynamicHeight(0.05),
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            SvgConstants.group.getSvg,
                                            height:
                                                context.dynamicHeight(0.035),
                                          ),
                                        ],
                                      );
                                    },
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) => Text(
                                      error.toString(),
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                        color: AppColors.lightPurple,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const TitleWidget(
                title: "0 Contributions",
              ),
              Padding(
                padding: context.paddingBottomLow,
                child: Material(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: context.dynamicHeight(0.29),
                    width: context.dynamicWidth(1),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: context.paddingAllLow,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 52; i++)
                            Column(
                              children: [
                                for (int j = 0; j < 7; j++)
                                  Padding(
                                    padding: EdgeInsets.all(
                                      context.dynamicHeight(0.004),
                                    ),
                                    child: Container(
                                      height: context.dynamicHeight(0.03),
                                      width: context.dynamicHeight(0.03),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightPurple,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const TitleWidget(
                title: "Join a Group",
              ),
              Material(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: context.dynamicWidth(1),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: context.paddingAllDefault,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: context.paddingBottomLow,
                        child: Text(
                          "Total Groups",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.lightPurple,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.whiteColor,
                              ),
                              cursorColor: AppColors.whiteColor,
                              decoration: InputDecoration(
                                hintText: "Group Name",
                                hintStyle:
                                    context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.lightPurple,
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
                          ),
                          Padding(
                            padding: context.paddingLeftLow,
                            child: GestureDetector(
                              onTap: () {},
                              child: Material(
                                child: Container(
                                  height: context.dynamicHeight(0.065),
                                  width: context.dynamicHeight(0.065),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightPurple,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child:
                                        Icon(Icons.done, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
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

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
      child: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(
          color: AppColors.lightPurple,
        ),
      ),
    );
  }
}
