import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webbrains_task/controller/user_controller.dart';
import 'package:webbrains_task/utility/app_colors.dart';
import 'package:webbrains_task/utility/app_strings.dart';
import 'package:webbrains_task/utility/app_textstyle.dart';
import 'package:webbrains_task/view/widget/bottom_navigation_bar.dart';
import 'package:webbrains_task/view/widget/profile_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  UserController controller = Get.find<UserController>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    controller.getCurrentUserData();
    controller.getAllUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 31),
                    child: Text(AppStrings.webbrains,
                        style: AppTextStyle.titleText),
                  ),
                ),
                const SizedBox(
                  height: 41,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 31,
                    ),
                    child: Text(
                      AppStrings.users,
                      style: AppTextStyle.headingText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 41,
                ),
                Obx(() {
                  return Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          tileColor: AppColors.white,
                          title: Text(
                            controller.availableUsers.value[index]?.name ?? '',
                            style: AppTextStyle.headingText3,
                          ),
                          subtitle: Text(
                            controller.availableUsers.value[index]?.email ?? '',
                            style: AppTextStyle.hintStyle,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor.withOpacity(0.1)),
                            child: Text(
                              controller.availableUsers.value[index]?.name
                                      .characters.first ??
                                  '',
                              style: AppTextStyle.headingText3.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: controller.availableUsers.value.length,
                    ),
                  );
                })
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primaryColor),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  controller.currentUser.value?.name ?? '',
                  style: AppTextStyle.headingText2,
                ),
                const SizedBox(
                  height: 19,
                ),
                ProfileTile(
                  prefix: AppStrings.email,
                  suffixText: controller.currentUser.value?.email ?? '',
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTile(
                  prefix: AppStrings.phone,
                  suffixText: controller.currentUser.value?.phoneNo ?? '',
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTile(
                  prefix: AppStrings.logout,
                  suffixWidget: GestureDetector(
                    onTap: () async {
                      controller.logout(context);
                    },
                    child: const Icon(
                      Icons.logout,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar(
        tabController: tabController,
      ),
    );
  }
}
