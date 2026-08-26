import 'package:flutter/material.dart';
import 'package:fixgo/features/stories/domain/entities/story_entity.dart';
import 'package:fixgo/l10n/app_localizations.dart';

Future<void> showStoryViewsSheet(
  BuildContext context, {
  required StoryEntity story,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => StoryViewsSheet(story: story),
  );
}

class StoryViewsSheet extends StatelessWidget {
  const StoryViewsSheet({super.key, required this.story});

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 350,
        child: story.viewedBy.isEmpty
            ? Center(child: Text(AppLocalizations.of(context).noStoryViewsYet))
            : Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: story.viewedBy.length,
                  itemBuilder: (context, index) {
                    final viewer = story.viewedBy[index];
                    final String userName =
                        viewer['userName'] ?? AppLocalizations.of(context).user;
                    final String userImage = viewer['userImage'] ?? '';

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: userImage.isEmpty
                            ? _colorFromName(userName)
                            : Colors.grey.shade200,
                        backgroundImage: userImage.isNotEmpty
                            ? NetworkImage(userImage)
                            : null,
                        child: userImage.isEmpty
                            ? Text(
                                userName.isNotEmpty
                                    ? userName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      title: Text(userName),
                      tileColor: Colors.white,
                    );
                  },
                ),
              ),
      ),
    );
  }

  Color _colorFromName(String name) {
    const colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.brown,
    ];
    return colors[(name.hashCode % colors.length).abs()];
  }
}
