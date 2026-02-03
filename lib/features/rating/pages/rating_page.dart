import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/formatter.dart';
import 'package:crypto_simulator/core/utils/validator.dart';
import 'package:crypto_simulator/features/rating/providers/rating_provider.dart';
import 'package:crypto_simulator/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/settings_button.dart';

@RoutePage()
class RatingPage extends ConsumerWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final usersP = ref.watch(ratingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.rating),
        automaticallyImplyLeading: false,
        actions: [const SettingsButton()],
      ),
      body: Padding(
        padding: const .all(16),
        child: Center(
          child: usersP.when(
            data: (users) => _UsersList(users: users),
            error: (_, _) => const UnknownError(),
            loading: () => const Loader(),
          ),
        ),
      ),
    );
  }
}

class _UsersList extends StatelessWidget {
  final UsersWithCurrentUserId users;

  const _UsersList({required this.users});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: users.users.length,
      itemBuilder: (context, index) {
        final user = users.users[index];
        final isCurrentUser = user.user.id == users.currentUserId;
        return Card(
          shape: RoundedRectangleBorder(
            side: isCurrentUser
                ? BorderSide(color: theme.primaryColor, width: 2.0)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Text('${index + 1}', style: theme.textTheme.displayMedium),
            title: Text(user.user.name),
            subtitle: Text(user.fullBalance.price4),
            trailing: !isCurrentUser ? const Icon(Icons.chevron_right) : null,
            onTap: !isCurrentUser
                ? () => context.pushRoute(BriefcaseRoute(user: user.user))
                : null,
          ),
        );
      },
    );
  }
}
