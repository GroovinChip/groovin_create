import 'package:rxdart/rxdart.dart';

extension BehaviorSubjectX on BehaviorSubject {
  dynamic get currentValue => this.valueWrapper!.value;
}