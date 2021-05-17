// @dart=2.9
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/error_display.dart';
import '../../../../core/presentation/widgets/loading_display.dart';
import '../../../../core/presentation/widgets/waiting_display.dart';
import '../bloc/stories_bloc.dart';
import '../widgets/stories_display.dart';

class StoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesBloc, StoriesState>(builder: (context, state) {
        BlocProvider.of<StoriesBloc>(context).add(BGetStories());
        if (state is Empty) {
          return WaitingDisplay();
        }
        if (state is Error) {
          return ErrorDisplay(message: state.message);
        }
        if (state is Loading) {
          return LoadingDisplay();
        }
        if (state is Loaded) {
          return StoriesDisplay(stories: state.stories);
        }
        return ErrorDisplay(message: "Something went wrong");
      }
    );
  }
}
