import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/controllers/app_info_controller.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

class AboutWidget extends ConsumerWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionAsync = ref.watch(appVersionProvider);

    return versionAsync.when(
      data: (version) => FPVText(
        text: version,
      ).s12().color(AppColors.primary.withAlpha(100)).bold(),
      loading: () => const Text('...'),
      error: (_, __) => const Text('N/A'),
    );
  }
}
