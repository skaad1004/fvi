import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogsInfo {
  static Future<T> show<T>({
    required BuildContext context,
    required Future<T> process,
    String? title,
    ValueSetter<T>? callback,
  }) async {
    var onComplete = () {};

    // ignore: unawaited_futures
    _showDialogLoading(context, title).then((_) {
      onComplete();
    });

    final result = await process;

    onComplete = () {
      if (callback != null) {
        callback(result);
      }
    };

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(result);

    return result;
  }

  static Future<void> _showDialogLoading(BuildContext context, String? title) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(child: Text(title ?? 'Cargando...')),
          ],
        ),
      ),
    );
  }

  static Future<bool> confirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
    Widget? confirmIcon,
    Widget? cancelIcon,
    bool? showCancelButton = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (showCancelButton == true)
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop(false);
                if (onCancel != null) onCancel();
              },
              icon: cancelIcon ?? const Icon(Icons.cancel),
              label: Text(cancelText ?? 'Cancelar'),
            ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop(true);
              onConfirm();
            },
            icon: confirmIcon ?? const Icon(Icons.check_circle),
            label: Text(confirmText),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
