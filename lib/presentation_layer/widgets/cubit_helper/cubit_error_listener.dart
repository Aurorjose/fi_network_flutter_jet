import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/base_state.dart';

/// Widget that exposes methods for listening to new errors on [AnyCubit].
class CubitErrorListener<AnyCubit extends Cubit<BaseState>, CubitAction>
    extends StatelessWidget {
  /// The set of actions related to the errors that will be listened.
  final Set<CubitAction> actions;

  /// Called when a new [CubitConnectivityError] is emited by the [AnyCubit].
  final ValueChanged<CubitConnectivityError<CubitAction>> onConnectivityError;

  /// Called when a new [CubitAPIError] is emited by the [AnyCubit].
  final ValueChanged<CubitAPIError<CubitAction>> onAPIError;

  /// The child.
  final Widget? child;

  /// Creates a new [CubitErrorListener].
  const CubitErrorListener({
    Key? key,
    required this.actions,
    required this.onConnectivityError,
    required this.onAPIError,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<AnyCubit, BaseState>(
            listenWhen: (previous, current) {
              final previousConnectivityErrors = previous.errors
                  .whereType<CubitConnectivityError<CubitAction>>()
                  .where((error) => actions.contains(error.action));
              final currentConnectivityErrors = current.errors
                  .whereType<CubitConnectivityError<CubitAction>>()
                  .where((error) => actions.contains(error.action));

              return currentConnectivityErrors.length >
                  previousConnectivityErrors.length;
            },
            listener: (context, state) {
              final newConnectivityError = state.errors
                  .whereType<CubitConnectivityError<CubitAction>>()
                  .where((error) => actions.contains(error.action))
                  .last;

              onConnectivityError(newConnectivityError);
            },
          ),
          BlocListener<AnyCubit, BaseState>(
            listenWhen: (previous, current) {
              final previousAPIErrors = previous.errors
                  .whereType<CubitAPIError<CubitAction>>()
                  .where((error) => actions.contains(error.action));
              final currentAPIErrors = current.errors
                  .whereType<CubitAPIError<CubitAction>>()
                  .where((error) => actions.contains(error.action));

              return currentAPIErrors.length > previousAPIErrors.length;
            },
            listener: (context, state) {
              final newAPIError = state.errors
                  .whereType<CubitAPIError<CubitAction>>()
                  .where((error) => actions.contains(error.action))
                  .last;

              onAPIError(newAPIError);
            },
          ),
        ],
        child: child ?? const SizedBox.shrink(),
      );
}
