import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:google_maps_angular/google_maps_angular.dart';
import 'package:google_maps/google_maps.dart';

void main() {
  applicationFactory().rootContextType(RootContext).addModule(new DecoratorsModule()).run();
}

@Injectable()
class RootContext {

  num zoom;
  LatLngWrapper center;
  MapTypeId mapTypeId;

  GMap gmap;

  Icon icon;
  Size iconScaledSize = new Size(30, 30);

  List<LatLngWrapper> markers = new List();
  List<LatLngWrapper> markersWithIcon = new List();

  RootContext() {
    center = new LatLngWrapper(33.55770396470521, -7.5963592529296875);
    zoom = 9;
    mapTypeId = MapTypeId.ROADMAP;
  }

  gmapCreated(GMap gmap) {
    this.gmap = gmap;
  }

  iconCreated(Icon icon) {
    this.icon = icon;
  }

  mapClick(MouseEvent e) {
    markers.add(new LatLngWrapper.fromLatLng(e.latLng));
  }

  mapRightClick(MouseEvent e) {
    markersWithIcon.add(new LatLngWrapper.fromLatLng(e.latLng));
  }

  rightClick(LatLngWrapper latLngWrapper) {
    markers.remove(latLngWrapper);
  }

  rightClickWithIcon(LatLngWrapper latLngWrapper) {
    markersWithIcon.remove(latLngWrapper);
  }

}
