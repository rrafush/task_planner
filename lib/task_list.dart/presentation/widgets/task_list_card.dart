import 'package:flutter/material.dart';
import 'package:simple_to_do_app/shared/theme/dimensions.dart';
import 'package:simple_to_do_app/shared/utils/extensions/date_time.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.onDelete,
    required this.onEdit,
  });

  final String title;
  final String description;
  final DateTime date;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.base),
      padding: const EdgeInsets.all(Dimensions.base),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        color: colorsTheme.surface.withOpacity(0.6),
        border: Border.all(
          color: colorsTheme.surface,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month,
            color: colorsTheme.onPrimary,
          ),
          const SizedBox(
            width: Dimensions.base,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width * 0.4,
                ),
                child: Text(
                  title.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorsTheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(
                height: Dimensions.md,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width * 0.45),
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: colorsTheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(
                height: Dimensions.base,
              ),
              Text(
                date.formatDateToLocale(
                  languageCode: Localizations.localeOf(context).languageCode,
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: colorsTheme.secondary,
                    ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
            ),
            color: colorsTheme.error,
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(
              Icons.edit_outlined,
            ),
            color: colorsTheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
