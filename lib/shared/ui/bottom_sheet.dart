import 'package:flutter/material.dart';

Future<T?> displayModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  VoidCallback? onClosing,
}) async {
  return await showModalBottomSheet<T?>(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          20.0,
        ),
      ),
    ),
    context: context,
    builder: (context) {
      final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.only(
          bottom: bottomPadding,
        ),
        child: SingleChildScrollView(
          child: child,
        ),
      );
    },
  ).whenComplete(
    () => onClosing?.call(),
  );
}
