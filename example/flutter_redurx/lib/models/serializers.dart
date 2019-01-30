import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

import '../models/app_state.dart';
import '../models/app_tab.dart';
import '../models/extra_actions.dart';
import '../models/todo.dart';
import '../models/visibility_filter.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AppTab,
  ExtraAction,
  VisibilityFilter,
  AppState,
  Todo,
])
final Serializers serializers = _$serializers;
