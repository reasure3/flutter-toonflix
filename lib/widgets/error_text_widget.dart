import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.failToLoadData,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }
}
