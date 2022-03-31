import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:learning/core/failures.dart';
import 'package:learning/core/value_object.dart';
import 'package:learning/domain/notes/todo_item.dart';
import 'package:learning/domain/notes/value_objects.dart';

part 'notes.freezed.dart';

@freezed
abstract class Note implements _$Note {
  const Note._();
  const factory Note({
    required UniqueId id,
    required NoteBody body,
    required NoteColor color,
    required List3<TodoItem> todos,
  }) = _Note;
  factory Note.empty() => Note(
      id: UniqueId(),
      body: NoteBody(''),
      color: NoteColor(NoteColor.predefinedColors[0]),
      todos: List3(emptyList()));

  Option<ValueFailure<dynamic>> get failureOption {
    return body.failureOrUnit
        .andThen(todos.failureOrUnit)
        .andThen(todos
            .getOrCrash()
            .map((todoItem) => todoItem.failureOption)
            .filter((o) => o.isSome())
            .getOrElse(0, (_) => none())
            .fold(() => right(unit), (a) => left(a)))
        .fold((l) => some(l), (r) => none());
  }
}
