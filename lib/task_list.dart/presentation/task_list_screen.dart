import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_to_do_app/shared/theme/dimensions.dart';
import 'package:simple_to_do_app/shared/ui/bottom_sheet.dart';
import 'package:simple_to_do_app/shared/ui/scaffold_with_app_bar.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/widgets/create_or_edit_task_bottom_sheet.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/widgets/task_list_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({
    super.key,
  });

  @override
  State<TaskListScreen> createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();
  final Tween<double> _tween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(TaskLoadedRequested());
  }

  Future<void> _createTask() async {
    final bloc = context.read<TaskBloc>();
    final lenght = bloc.state.tasks.length;
    final index = lenght;
    displayModalBottomSheet(
      context: context,
      child: CreateOrEditTaskBottomSheet(
        index: index,
        animatedListKey: _animatedListKey,
      ),
      onClosing: () {
        bloc.add(TaskLoadedRequested());
      },
    );
  }

  void _editTask({
    required String title,
    required String description,
    required String id,
    required DateTime date,
  }) {
    displayModalBottomSheet(
      context: context,
      child: CreateOrEditTaskBottomSheet(
        title: title,
        description: description,
        id: id,
        date: date,
        index: 0,
        animatedListKey: _animatedListKey,
      ),
      onClosing: () => context.read<TaskBloc>().add(TaskLoadedRequested()),
    );
  }

  void _onDelete(String id) {
    context.read<TaskBloc>().add(TaskDeletionRequested(id));
    final bloc = context.read<TaskBloc>();
    final index = bloc.state.tasks.indexWhere(
      (element) => element.id == id,
    );
    final todo = bloc.state.tasks[index];
    _animatedListKey.currentState?.removeItem(
      duration: const Duration(milliseconds: 500),
      index,
      (context, animation) => ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
        ),
        child: TaskListCard(
          title: todo.title,
          description: todo.description,
          date: todo.date,
          onDelete: () {},
          onEdit: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        onPressed: _createTask,
        child: const Icon(Icons.add),
      ),
      child: BlocBuilder<TaskBloc, TaskState>(
        buildWhen: (previous, current) => previous.tasks != current.tasks,
        builder: (context, state) {
          final Widget content;
          if (state is TaskLoadInProgress) {
            content = const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskLoadFailure) {
            content = Column(
              key: const Key('ErrorState'),
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/error.json',
                  height: 400,
                ),
                Text(
                  AppLocalizations.of(context)!.errorMessage,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ],
            );
          } else {
            content = Stack(
              children: [
                Visibility(
                  visible: state.tasks.isEmpty,
                  maintainAnimation: true,
                  maintainState: true,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInCubic,
                    opacity: state.tasks.isEmpty ? 1 : 0,
                    child: Column(
                      key: const Key('EmptyState'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          'assets/empty_state.json',
                          height: 400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.emptyStateMessage,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedList(
                  key: _animatedListKey,
                  initialItemCount: state.tasks.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.base,
                    vertical: Dimensions.xl,
                  ),
                  itemBuilder: (context, index, animation) {
                    return ScaleTransition(
                      scale: _tween.animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInCubic,
                        ),
                      ),
                      child: TaskListCard(
                        title: state.tasks[index].title,
                        description: state.tasks[index].description,
                        date: state.tasks[index].date,
                        onDelete: () => _onDelete(state.tasks[index].id),
                        onEdit: () => _editTask(
                          title: state.tasks[index].title,
                          description: state.tasks[index].description,
                          id: state.tasks[index].id,
                          date: state.tasks[index].date,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: content,
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
