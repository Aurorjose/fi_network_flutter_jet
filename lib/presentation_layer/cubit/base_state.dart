import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../../data_layer/network/network_client.dart';

/// The base abstract error class.
///
/// All cubit errors should extend this.
abstract class CubitError extends Equatable {}

/// Cubit error representing a connectivity error.
class CubitConnectivityError<CubitAction> extends CubitError {
  /// The action that the cubit was performing when the error occurred .
  final CubitAction action;

  /// Creates a new [CubitConnectivityError].
  CubitConnectivityError({
    required this.action,
  }) : super();

  @override
  List<Object?> get props => [
        action,
      ];
}

/// Cubit error representing an API error.
class CubitAPIError<CubitAction> extends CubitError {
  /// The action that the cubit was performing when the error occurred .
  final CubitAction action;

  /// The optional error message.
  final String? message;

  /// Creates a new [CubitAPIError].
  CubitAPIError({
    required this.action,
    this.message,
  }) : super();

  @override
  List<Object?> get props => [
        action,
        message,
      ];
}

/// Interface for all the cubit states.
///
/// It unifies the way of handling:
///   - Busy actions
///   - Error handling
abstract class BaseState<CubitAction> extends Equatable {
  /// The actions that the cubit is performing.
  final UnmodifiableSetView<CubitAction> actions;

  /// The cubit errors.
  final UnmodifiableSetView<CubitError> errors;

  /// Creates a new [BaseState].
  BaseState({
    Set<CubitAction>? actions,
    Set<CubitError>? errors,
  })  : actions = UnmodifiableSetView(actions ?? <CubitAction>{}),
        errors = UnmodifiableSetView(errors ?? <CubitError>{});

  /// Method for creating a copy of this [BaseState].
  BaseState copyWith();

  /// Adds the passed action to the current actions and returns the
  /// new set.
  Set<CubitAction> addAction(CubitAction action) => actions.union({action});

  /// Adds the passed actions to the current actions and returns the
  /// new set.
  Set<CubitAction> addActions(Set<CubitAction> actions) =>
      actions.union(actions);

  /// Removes the passed action from the current actions and returns the
  /// new set.
  Set<CubitAction> removeAction(CubitAction action) =>
      actions.difference({action});

  /// Removed the passed errors from all the errors
  Set<CubitError> removeErrors(Set<CubitError> errors) =>
      errors.difference(errors);

  /// Removes the passed actions from the current actions and returns the
  /// new set.
  Set<CubitAction> removeActions(Set<CubitAction> actions) =>
      actions.difference(actions);

  /// Builds the corresponding [CubitError] with the passed action and
  /// exception, adds it to the current errors and returns the new set.
  Set<CubitError> addErrorFromException({
    required CubitAction action,
    required Exception exception,
  }) {
    if (exception is ConnectivityException) {
      return errors.union({
        CubitConnectivityError<CubitAction>(
          action: action,
        )
      });
    } else if (exception is NetworkException) {
      return errors.union({
        CubitAPIError<CubitAction>(
          action: action,
          message: exception.message,
        )
      });
    }

    /// Corner case. The error concentrator should handle this.
    throw exception;
  }

  /// Removes any error related to the passed action and returns the new set.
  Set<CubitError> removeErrorForAction(CubitAction action) =>
      errors.where((error) {
        final action = error is CubitConnectivityError<CubitAction>
            ? error.action
            : error is CubitAPIError<CubitAction>
                ? error.action
                : null;

        return action != action;
      }).toSet();

  /// Returns whether the passed action contains errors or not.
  bool actionHasErrors(CubitAction action) =>
      errors
          .whereType<CubitConnectivityError<CubitAction>>()
          .where((error) => error.action == action)
          .isNotEmpty ||
      errors
          .whereType<CubitAPIError<CubitAction>>()
          .where((error) => error.action == action)
          .isNotEmpty;
}
