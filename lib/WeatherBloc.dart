import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherbloc/WeatherModel.dart';
import 'package:weatherbloc/WeatherRepo.dart';

class WeatherEvent extends Equatable {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

//FetchWeather event
class FetchWeather extends WeatherEvent {
  final _city;

  FetchWeather(this._city);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

//weather state WeatherIsNotSearched
class WeatherIsNotSearched extends WeatherState {}

//weather state WeatherIsLoading
class WeatherIsLoading extends WeatherState {}

//weather WeatherIsLoaded
class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {}

//end of Events and states

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched());

  @override
  // ignore: todo
  // TODO: implement initialState
  // ignore: override_on_non_overriding_member
  WeatherState get initialState => WeatherIsNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // ignore: todo
    // TODO: implement mapEventToState
    if (event is FetchWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather = await weatherRepo.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        print(_);
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
