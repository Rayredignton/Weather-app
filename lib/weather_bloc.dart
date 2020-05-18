

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/weatherModel.dart';
import 'package:weather_app/weatherrepo.dart';

class WeatherEvent extends Equatable{
  @override
  List<Object> get props =>[];

}

class FetchWeather extends WeatherEvent{

  final _city;
  FetchWeather(this._city);

  List<Object> get props => [_city];


}
class ResetWeather extends WeatherEvent{

}
class Weatherstate extends Equatable{
  List <Object> get props =>[];

 
}

class WeatherIsNotSearched extends Weatherstate{

}

class WeatherIsLoading extends Weatherstate{

}

class WeatherIsLoaded extends Weatherstate{


  final _weather;
  
  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;
}

class WeatherIsNotLoaded extends Weatherstate{

}

class WeatherBloc extends Bloc<WeatherEvent, Weatherstate>{

WeatherRepo weatherRepo;
 WeatherBloc(this.weatherRepo);


 @override
  // TODO: implement initialState
  Weatherstate get initialState => WeatherIsNotSearched();

  @override
    Stream<Weatherstate> mapEventToState(WeatherEvent event) async*{

      if (event is FetchWeather){
        yield WeatherIsLoading();

        try{
          WeatherModel weather = await weatherRepo.getWeather(event._city);
          yield WeatherIsLoaded(weather);


        }
        catch(_){
          print(_);
          yield WeatherIsNotLoaded();
        }
    }else if (event is ResetWeather){
      yield WeatherIsNotSearched();
    }
    }

 
}


