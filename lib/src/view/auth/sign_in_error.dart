import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:nf_base/src/model/auth/auth_repository.dart';
import 'package:nf_base/src/utils/l10n_context.dart';
import 'package:nf_base/src/widgets/feedback.dart';

/// Shows an error snackbar when the sign-in [signInMutation] fails.
///
/// Meant to be used as the listener of `ref.listen(signInMutation, ...)`.
void showSignInErrorSnackBar(BuildContext context, MutationState<void> state) {
  if (state case MutationError(:final error) when error is! SignInCancelledException) {
    showSnackBar(context, context.l10n.mobileSomethingWentWrong, type: SnackBarType.error);
  }
}
