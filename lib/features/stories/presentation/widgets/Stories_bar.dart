library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/add_story_bottom_sheet.dart';
import 'package:fixgo/features/stories/domain/entities/story_entity.dart';
import 'package:fixgo/features/stories/presentation/views/story_viewer_view.dart';
import 'package:fixgo/features/stories/presentation/widgets/stories_shimmer.dart';
import 'package:fixgo/l10n/app_localizations.dart';

import '../manager/stories_cubit/stories_cubit.dart';
import '../manager/stories_cubit/stories_state.dart';

class StoriesBar extends StatefulWidget {
  final bool isWorker;

  const StoriesBar({super.key, required this.isWorker});

  @override
  State<StoriesBar> createState() => _StoriesBarState();
}

class _StoriesBarState extends State<StoriesBar> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StoriesCubit>().getStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<StoriesCubit, StoriesState>(
        builder: (context, state) {
          /// ===============================
          /// Loading
          /// ===============================

          if (state is StoriesLoading) {
            return SizedBox(
              height: kIsWeb ? 100 : 90,
              child: Center(child: StoriesShimmer(isWorker: widget.isWorker)),
            );
          }

          /// ===============================
          /// Failure
          /// ===============================

          if (state is StoriesFailure) {
            return SizedBox(
              height: kIsWeb ? 100 : 90,
              child: Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    fontSize: AppSizes.sp(12),
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }

          /// ===============================
          /// Success
          /// ===============================
          if (state is StoriesSuccess) {
            final stories = state.stories;

            final Map<String, List<StoryEntity>> groupedStories = {};

            for (final story in stories) {
              if (groupedStories.containsKey(story.userId)) {
                groupedStories[story.userId]!.add(story);
              } else {
                groupedStories[story.userId] = [story];
              }
            }

            final groupedList = groupedStories.values.toList();

            /// ✅ لو مفيش استوريهات
            if (groupedList.isEmpty && !widget.isWorker) {
              return const SizedBox.shrink();
            }

            return SizedBox(
              height: kIsWeb ? 100 : 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),

                /// لو Worker يظهر + أضف حالة
                itemCount: widget.isWorker
                    ? groupedList.length + 1
                    : groupedList.length,

                itemBuilder: (context, index) {
                  /// ===============================
                  /// أول عنصر = أضف حالة
                  /// ===============================

                  if (widget.isWorker && index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              AddStoryBottomSheet.show(context);
                            },
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xff2977E5),
                                  width: 2.5,
                                ),
                              ),
                              child: const Center(
                                child: Icon(Icons.add, size: 32),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          SizedBox(
                            width: 60,
                            child: Text(
                              AppLocalizations.of(context).addStory,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppSizes.sp(10),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  /// ===============================
                  /// Story Item
                  /// ===============================

                  final userStories = widget.isWorker
                      ? groupedList[index - 1]
                      : groupedList[index];

                  final story = userStories.first;

                  final String? storyImage =
                      story.storyImage ?? story.userImage;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<StoriesCubit>(),
                                  child: StoryViewerScreen(
                                    stories: userStories,
                                    initialIndex: 0,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff2977E5),
                            ),
                            child: CircleAvatar(
                              radius: AppSizes.r(30),
                              backgroundColor: Colors.grey.shade300,

                              backgroundImage:
                                  storyImage != null && storyImage.isNotEmpty
                                  ? NetworkImage(storyImage)
                                  : null,

                              child: (storyImage == null || storyImage.isEmpty)
                                  ? Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Text(
                                        story.text.length > 8
                                            ? story.text.substring(0, 8)
                                            : story.text,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          height: 1.6,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        SizedBox(
                          width: 60,
                          child: Text(
                            story.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppSizes.sp(10),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
