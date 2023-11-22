part of 'example_bloc.dart';

@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = _Initial;
  const factory ExampleState.loadInProgress() = _LoadInProgress;
}