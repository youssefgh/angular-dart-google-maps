import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:google_maps_angular/google_maps_angular.dart';
import 'package:google_maps/google_maps.dart';
import 'package:observe/observe.dart';

import 'dart:html' hide MouseEvent;

void main() {
  applicationFactory().rootContextType(RootContext).addModule(new DecoratorsModule()).run();
}

@Injectable()
class RootContext {

  num zoom;
  LatLngWrapper center;
  MapTypeId mapTypeId;

  GMap gmap;

  ObservableList<LatLngWrapper> path;
  List<List<LatLngWrapper>> paths = new List();

  LatLng infoWindowPosition;

  RootContext() {
    center = new LatLngWrapper(33.55770396470521, -7.5963592529296875);
    zoom = 9;
    mapTypeId = MapTypeId.ROADMAP;
  }

  gmapCreated(GMap gmap) {
    this.gmap = gmap;
  }

  mapClick(MouseEvent e) {
    try {
      path.add(new LatLngWrapper.fromLatLng(e.latLng));
    } on NoSuchMethodError {
      window.alert("create a polyline first");
    }
  }

  create() {
    path = new ObservableList();
  }

  remove() {
    path = null;
  }

  save() {
    paths.add(path);
    remove();
  }

  mouseOver(PolyMouseEvent e) {
    infoWindowPosition = e.latLng;
  }

  mouseOut(PolyMouseEvent e) {
    infoWindowPosition = null;
  }

}
