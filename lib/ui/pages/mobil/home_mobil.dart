import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/widgets/molecules/list_founds.dart';

class HomeMobileLayout extends ConsumerWidget {
  const HomeMobileLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(foundsControllerProvider);
    return ListFounds(state: state, ref: ref);
  }
}
