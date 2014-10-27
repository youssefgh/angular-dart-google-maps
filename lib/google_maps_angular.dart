library google_maps_angular;

import 'package:angular/angular.dart';
import 'package:google_maps/google_maps.dart';

import 'package:google_maps_angular/decorator/decorator.dart';

part 'core/latlng_wrapper.dart';

class DecoratorsModule extends Module {
  
  DecoratorsModule(){
    bind(GMapDecorator);
    bind(MarkerDecorator);
    bind(IconDecorator);
    bind(PolylineDecorator);
    bind(InfoWindowDecorator);
  }
  
}