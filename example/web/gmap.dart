import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:google_maps_angular/google_maps_angular.dart';
import 'package:google_maps/google_maps.dart';

import 'dart:html' hide MouseEvent;

void main() {
  applicationFactory().rootContextType(RootContext).addModule(new DecoratorsModule()).run();
}

@Injectable()
class RootContext {

  num zoom;
  LatLngWrapper center;
  MapTypeId mapTypeId;
  LatLngBounds bounds;

  RootContext() {
    center = new LatLngWrapper(33.55770396470521, -7.5963592529296875);
    zoom = 9;
    mapTypeId = MapTypeId.ROADMAP;
  }

  click(MouseEvent e) {
    window.alert('Click at ' + e.latLng.toString());
  }

  rightClick(MouseEvent e) {
    window.alert('RightClick at ' + e.latLng.toString());
  }
  
  GMap gmap;
  GMap gmapx;


  gmapCreated(GMap gmap) {
    this.gmap = gmap;
  }
  
  gmapCreatedx(GMap gmapx) {
    this.gmapx = gmapx;
  }

}
