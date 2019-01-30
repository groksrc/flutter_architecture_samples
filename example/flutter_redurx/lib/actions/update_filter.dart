import 'package:flutter_redurx/flutter_redurx.dart';

import '../models/app_state.dart';
import '../models/visibility_filter.dart';

class UpdateFilter implements Action<AppState> {
  final VisibilityFilter filter;

  UpdateFilter(this.filter);

  @override
  AppState reduce(AppState state) {
    return state.rebuild((b) => b..activeFilter = filter);
  }
}
