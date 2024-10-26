import 'package:findrobe_app/providers/admin/admin_graph_index_provider.dart';
import 'package:findrobe_app/providers/admin/admin_monitor_provider.dart';
import 'package:findrobe_app/providers/client/auth_data_provider.dart';
import 'package:findrobe_app/providers/client/user_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/admin_charts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  final List<Map<String, int>> _graphDataList = [
    {}, {}, {}, {}
  ];
  final List<String> _graphTitleList = [
    "Clothings recorded each month",
    "Comments written each month",
    "Posts written each month",
    "Users registered each month"
  ];
  
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await Future.wait([
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllComments(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllLikes(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllClothings(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllClothingsByMonth(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllCommentsByMonth(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllPostsByMonth(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllUsersByMonth(),
      ]);
    });
  }

  Future<void> _refreshAnalytics() async {
    _graphDataList.clear();

    Future.microtask(() async {
      await Future.wait([
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllComments(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllLikes(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllClothings(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllClothingsByMonth(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllCommentsByMonth(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllPostsByMonth(),
        ref.read(adminMonitorNotifierProvider.notifier).fetchAllUsersByMonth(),
      ]);
    });

    _graphDataList.addAll([
      ref.watch(adminMonitorNotifierProvider).clothingsMonth,
      ref.watch(adminMonitorNotifierProvider).commentsMonth,
      ref.watch(adminMonitorNotifierProvider).postsMonth,
      ref.watch(adminMonitorNotifierProvider).usersMonth,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final analytics = ref.watch(adminMonitorNotifierProvider);
    final currentIndex = ref.watch(adminGraphIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "Analytics"),
              const SizedBox(height: 30.0),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.black,
                  backgroundColor: AppColors.beige,
                  onRefresh: _refreshAnalytics,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _graphDataList.any((graphData) => graphData.isNotEmpty) ?
                          Text(
                            _graphTitleList[currentIndex],
                            style: AppFonts.poiret20
                          )
                        :
                          Text(
                            "Refresh to view graph...",
                            style: AppFonts.poiret20
                          ),
                        const SizedBox(height: 10.0),
                        AdminCharts(
                          graphData: _graphDataList[currentIndex],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FindrobeButton(
                              width: 150,
                              buttonText: "Previous", 
                              onPressed: () {
                                ref.read(adminGraphIndexProvider.notifier).previous();
                              }
                            ),
                            FindrobeButton(
                              width: 150,
                              buttonText: "Next", 
                              onPressed: () {
                                ref.read(adminGraphIndexProvider.notifier).next();
                              }
                            )
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 70) / 2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.overlayBlack
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Users",
                                    style: AppFonts.forum16white,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.person_3_fill,
                                        color: AppColors.beige,
                                        size: 28.0,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        "${analytics.allUsers.length}",
                                        style: AppFonts.poiret24,
                                      )
                                    ]
                                  )
                                ],
                              )
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 70) / 2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.overlayBlack
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Posts",
                                    style: AppFonts.forum16white,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.rectangle_dock,
                                        color: AppColors.beige,
                                        size: 28.0,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        "${analytics.allPosts.length}",
                                        style: AppFonts.poiret24,
                                      )
                                    ]
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 70) / 2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.overlayBlack
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Comments",
                                    style: AppFonts.forum16white,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.chat_bubble_2_fill,
                                        color: AppColors.beige,
                                        size: 28.0,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        "${analytics.allComments}",
                                        style: AppFonts.poiret24,
                                      )
                                    ]
                                  )
                                ],
                              )
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 70) / 2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.overlayBlack
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Likes",
                                    style: AppFonts.forum16white,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.hand_thumbsup_fill,
                                        color: AppColors.beige,
                                        size: 28.0,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        "${analytics.allLikes}",
                                        style: AppFonts.poiret24,
                                      )
                                    ]
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 70) / 2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.overlayBlack
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Clothings",
                                    style: AppFonts.forum16white,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.collections,
                                        color: AppColors.beige,
                                        size: 28.0,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        "${analytics.allClothings}",
                                        style: AppFonts.poiret24,
                                      )
                                    ]
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        FindrobeButton(
                          buttonText: "Log Out", 
                          alternative: true,
                          buttonColor: AppColors.black,
                          onPressed: () {
                            ref.read(userDataNotifierProvider.notifier).logoutUser(ref);
                            ref.read(authDataNotifierProvider.notifier).clearSession();
                            ref.read(adminMonitorNotifierProvider.notifier).clearAdmin();
                            Navigator.pushReplacementNamed(context, "/login");
                          }
                        )
                      ],
                    )
                  )
                )
              ),
            ]
          )
        )
      )
    );
  }
}