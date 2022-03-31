// import 'dart:ui';

// import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
// import 'package:learning/core/value_object.dart';
import 'package:learning/domain/notes/notes.dart';
import 'package:learning/domain/notes/todo_item.dart';
// import 'package:learning/domain/notes/value_objects.dart';

part 'notes_dtos.freezed.dart';
part 'notes_dtos.g.dart';

@freezed
abstract class NoteDto implements _$NoteDto {
  const NoteDto._();

  const factory NoteDto({
    String? id,
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    required String serverTimeStamp,
  }) = _NoteDto;

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
        id: note.id.getOrCrash(),
        body: note.body.getOrCrash(),
        color: note.color.getOrCrash().value,
        todos: note.todos
            .getOrCrash()
            .map(
              (todoItem) => TodoItemDto.fromDomain(todoItem),
            )
            .asList(),
        // serverTimeStamp: FieldValue.serverTimestamp(),
        serverTimeStamp: '18748998035802380');
  }

  // Note toDomain() {
  //   return Note(
  //     id: UniqueId.fromUniqueString(id),
  //     body: NoteBody(body),
  //     color: NoteColor(Color(color)),
  //     todos: List3(todos.map((dto) => dto.toDomain()).toImmutableList()),
  //   );
  // }

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore() {
    Map<String, dynamic> listDummy = {
      'id': '1',
      'body': 'this is the body',
      'color': '0xfffa8072',
      'todos': ''
    };
    // return NoteDto.fromJson(listDummy).copyWith(id: doc.id);
    return NoteDto.fromJson(listDummy);
  }
}

// class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
//   const ServerTimestampConverter();

//   @override
//   FieldValue fromJson(Object json) {
//     return FieldValue.serverTimestamp();
//   }

//   @override
//   Object toJson(FieldValue fieldValue) => fieldValue;
// }

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const TodoItemDto._();

  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrash(),
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  // TodoItem toDomain() {
  //   return TodoItem(
  //     id: UniqueId.fromUniqueString('$id'),
  //     name: TodoName('$name'),
  //     done: done,
  //   );
  // }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}
