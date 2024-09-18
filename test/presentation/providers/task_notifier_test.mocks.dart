// Mocks generated by Mockito 5.4.4 from annotations
// in check_list_demo/test/presentation/providers/task_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:check_list_demo/domain/entities/task.dart' as _i2;
import 'package:check_list_demo/domain/usecases/create_task_usecase.dart'
    as _i3;
import 'package:check_list_demo/domain/usecases/delete_task_usecase.dart'
    as _i6;
import 'package:check_list_demo/domain/usecases/get_task_by_id_usecase.dart'
    as _i7;
import 'package:check_list_demo/domain/usecases/update_task_usecase.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTask_0 extends _i1.SmartFake implements _i2.Task {
  _FakeTask_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CreateTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateTaskUseCase extends _i1.Mock implements _i3.CreateTaskUseCase {
  MockCreateTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Task> call(_i2.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [task],
        ),
        returnValue: _i4.Future<_i2.Task>.value(_FakeTask_0(
          this,
          Invocation.method(
            #call,
            [task],
          ),
        )),
      ) as _i4.Future<_i2.Task>);
}

/// A class which mocks [UpdateTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateTaskUseCase extends _i1.Mock implements _i5.UpdateTaskUseCase {
  MockUpdateTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Task> call(_i2.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [task],
        ),
        returnValue: _i4.Future<_i2.Task>.value(_FakeTask_0(
          this,
          Invocation.method(
            #call,
            [task],
          ),
        )),
      ) as _i4.Future<_i2.Task>);
}

/// A class which mocks [DeleteTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteTaskUseCase extends _i1.Mock implements _i6.DeleteTaskUseCase {
  MockDeleteTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> call(int? id) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [id],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [GetTaskByIdUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTaskByIdUseCase extends _i1.Mock
    implements _i7.GetTaskByIdUseCase {
  MockGetTaskByIdUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Task?> call(int? id) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [id],
        ),
        returnValue: _i4.Future<_i2.Task?>.value(),
      ) as _i4.Future<_i2.Task?>);
}
