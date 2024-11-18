import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_to_do_app/shared/theme/dimensions.dart';
import 'package:simple_to_do_app/shared/ui/date_time_picker.dart';
import 'package:simple_to_do_app/shared/utils/extensions/date_time.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';

class CreateOrEditTaskBottomSheet extends StatefulWidget {
  const CreateOrEditTaskBottomSheet({
    super.key,
    this.title,
    this.description,
    this.id,
    this.date,
    required this.animatedListKey,
    required this.index,
  });

  final String? title;
  final String? description;
  final String? id;
  final DateTime? date;
  final GlobalKey<AnimatedListState> animatedListKey;
  final int index;

  @override
  State<CreateOrEditTaskBottomSheet> createState() =>
      _CreateOrEditTaskBottomSheetState();
}

class _CreateOrEditTaskBottomSheetState
    extends State<CreateOrEditTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _date;
  bool get _isDateValid => _date.isAfter(DateTime.now());

  @override
  void initState() {
    super.initState();
    _title = widget.title ?? '';
    _description = widget.description ?? '';
    _date = widget.date ?? DateTime.now();
  }

  void _saveTask() {
    final isValid = _formKey.currentState!.validate() && _isDateValid;
    if (!isValid) return;
    if (isValid && widget.id == null) {
      context.read<TaskBloc>().add(
            TaskCreationRequested(
              title: _title,
              description: _description,
              date: _date,
            ),
          );
      widget.animatedListKey.currentState?.insertItem(
        widget.index,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    } else if (isValid && widget.id != null) {
      context.read<TaskBloc>().add(
            TaskUpdateRequested(
              id: widget.id!,
              title: _title,
              description: _description,
              date: _date,
            ),
          );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.xl,
        vertical: Dimensions.xl,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: const Key('TitleFormField'),
              initialValue: _title,
              maxLength: 40,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.title,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.titleRequired;
                }
                _title = value;
                return null;
              },
            ),
            const SizedBox(
              height: Dimensions.base,
            ),
            TextFormField(
              key: const Key('DescriptionFormField'),
              initialValue: _description,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                alignLabelWithHint: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius),
                  ),
                ),
              ),
              maxLines: 3,
              maxLength: 100,
              validator: (value) {
                if (value == null) return null;
                _description = value;
                return null;
              },
            ),
            const SizedBox(
              height: Dimensions.base,
            ),
            GestureDetector(
              onTap: () async {
                showDateTimePicker(
                  context: context,
                  locale: Localizations.localeOf(context),
                ).then((value) {
                  _date = value ?? _date;
                }).whenComplete(() => setState(() {}));
              },
              child: Container(
                key: const Key('DateFormField'),
                padding: const EdgeInsets.all(Dimensions.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  border: Border.all(
                    color: _isDateValid
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(
                      width: Dimensions.md,
                    ),
                    Text(
                      _date.formatDateToLocale(
                        languageCode:
                            Localizations.localeOf(context).languageCode,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!_isDateValid)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.sm, horizontal: Dimensions.base),
                child: Text(AppLocalizations.of(context)!.dateNotValid,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        )),
              ),
            const SizedBox(
              height: Dimensions.base,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTask,
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
