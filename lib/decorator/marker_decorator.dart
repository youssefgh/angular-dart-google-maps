part of decorator;

@Decorator(selector: '[marker]')
class MarkerDecorator implements AttachAware, DetachAware {

  Marker marker;
  GMap _gMap;
  String _title;
  Icon _icon;
  LatLngWrapper _position;
  bool _draggable;

  @NgCallback('on_click')
  Function onClick;
  @NgCallback('on_right_click')
  Function onRightclick;
  @NgCallback('on_dragend')
  Function onDragend;

  MarkerDecorator() {
    marker = new Marker();
  }

  @NgOneWay('gmap')
  set gMap(GMap gMap) {
    _gMap = gMap;
    marker.map = _gMap;
  }

  @NgOneWay('title')
  set title(String title) {
    _title = title;
    marker.title = _title;
  }

  @NgOneWay('icon')
  set icon(icon) {
    _icon = icon;
    marker.icon = _icon;
  }

  @NgTwoWay('position')
  set position(LatLngWrapper position) {
    _position = position;
    if (_position != null) marker.position = _position.latLng; else marker.position = null;
  }
  get position => _position;

  @NgOneWay('draggable')
  set draggable(bool draggable) {
    _draggable = draggable;
    marker.draggable = _draggable;
  }

  attach() {
    marker.onClick.listen((e) {
      onClick({
        "\$position": _position
      });
    });
    marker.onRightclick.listen((e) {
      onRightclick({
        "\$position": _position
      });
    });
    marker.onDragend.listen((e) {
      _position.latLng = marker.position;
      onDragend({
        "\$position": _position
      });
    });
  }

  detach() {
    marker.map = null;
  }

}
