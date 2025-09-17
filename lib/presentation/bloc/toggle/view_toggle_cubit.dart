import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_toggle_state.dart';

class ViewToggleCubit extends Cubit<bool> {
  ViewToggleCubit() : super(false);

  void toggleView() => emit(!state); 
}