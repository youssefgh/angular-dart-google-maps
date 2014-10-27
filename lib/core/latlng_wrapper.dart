part of google_maps_angular;

class LatLngWrapper {

  LatLng _latLng;

  num _lat;
  num _lng;

  LatLngWrapper(num lat, num lng) {
    latLng = new LatLng(lat, lng);
  }

  LatLngWrapper.fromLatLng(LatLng latLng) {
    this.latLng = latLng;
  }

  set lat(lat) {
    _lat = lat;
    _sync();
  }
  get lat => _lat;

  set lng(lng) {
    _lng = lng;
    _sync();
  }
  get lng => _lng;

  set latLng(latLng) {
    lat = latLng.lat;
    lng = latLng.lng;
    _latLng = latLng;
  }
  get latLng => _latLng;

  _sync() {
    _latLng = new LatLng(lat, lng);
  }

}
