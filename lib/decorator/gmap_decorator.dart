part of decorator;

@Decorator(selector: '[gmap]')
class GMapDecorator implements AttachAware, DetachAware {
  final Element element;
  GMap _gmap;
  num _zoom;
  LatLng _center;
  MapTypeId _mapTypeId;
  @NgTwoWay('bounds')
  LatLngBounds bounds;

  @NgCallback('on_click')
  Function onClick;
  @NgCallback('on_right_click')
  Function onRightclick;
  @NgCallback('on_created')
  Function onCreated;

  GMapDecorator(this.element);

  @NgTwoWay('zoom')
  set zoom(num zoom) {
    _zoom = zoom;
    if (_gmap != null) _gmap.zoom = zoom;
  }
  get zoom => _zoom;

  @NgTwoWay('center')
  set center(LatLng center) {
    _center = center;
    if (_gmap != null) _gmap.center = center;
  }
  get center => _center;

  @NgOneWay('map-type-id')
  set mapTypeId(MapTypeId mapTypeId) {
    _mapTypeId = mapTypeId;
    if (_gmap != null) _gmap.mapTypeId = mapTypeId;
  }

  attach() {
    _gmap = new GMap(element);
    zoom = _zoom;
    center = _center;
    mapTypeId = _mapTypeId;

    onCreated({"\$gmap": _gmap});

    _gmap.onZoomChanged.listen((e) {
      _zoom = _gmap.zoom;
    });

    _gmap.onBoundsChanged.listen((e) {
      bounds = _gmap.bounds;
      center = _gmap.center;
    });

    _gmap.onClick.listen((MouseEvent e) {
      onClick({"\$mouseEvent": e});
    });
    _gmap.onRightclick
        .listen((MouseEvent e) => onRightclick({"\$mouseEvent": e}));
  }

  detach() {}
}
