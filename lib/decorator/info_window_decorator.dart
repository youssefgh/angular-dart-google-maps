part of decorator;

@Decorator(selector: '[info-window]')
class InfoWindowDecorator implements AttachAware, DetachAware {

  GMap _gMap;
  InfoWindow _infoWindow;
  String _content;
  LatLng _position;

  InfoWindowDecorator(){
    _infoWindow = new InfoWindow();
  }
  
  InfoWindow get infoWindow => _infoWindow;

  @NgOneWay('gmap')
  set gMap(GMap gMap) {
    _gMap = gMap;
  }
  GMap get gMap => _gMap;

  @NgAttr('content')
  set content(String content){
    _content = content;
    _infoWindow.content = _content;
  }
  
  @NgOneWay('position')
  set position(LatLng position){
    _position = position;
    _infoWindow.position = _position;
    if(_position != null) _infoWindow.open(_gMap);
    else _infoWindow.close();
  }
  
  attach() {/*
    _infoWindow.content = content;
    _infoWindow.position = position;*/
  }

  detach() {
    //_infoWindow.close();
    _gMap = null;
  }

}
