// @dart=2.9
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/error_display.dart';
import '../../../../core/presentation/widgets/loading_display.dart';
import '../../../../core/presentation/widgets/waiting_display.dart';
import '../bloc/countries_bloc.dart';
import '../widgets/countries_display.dart';

class CountriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(builder: (context, state) {
        BlocProvider.of<CountriesBloc>(context).add(BGetCountries());
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
          return CountriesDisplay(countries: state.countries);
        }
        return ErrorDisplay(message: "Something went wrong");
      }
    );
  }
}
