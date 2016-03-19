part of decorator;

@Decorator(selector: '[polyline]')
class PolylineDecorator implements AttachAware, DetachAware {

  Polyline _polyline;
  GMap _gMap;
  String _strokeColor;
  bool _visible;
  bool _editable;
  ObservableList<LatLngWrapper> _path;
  bool _removePointOnRightclick;

  StreamSubscription _onInsertAt;
  StreamSubscription _onSetAt;
  StreamSubscription _onRemoveAt;
  StreamSubscription _onPathChange;

  @NgCallback('on_click')
  Function onClick;
  @NgCallback('on_dbl_click')
  Function onDblClick;
  @NgCallback('on_right_click')
  Function onRightclick;
  @NgCallback('on_mouseover')
  Function onMouseover;
  @NgCallback('on_mouseout')
  Function onMouseout;

  PolylineDecorator() {
    _polyline = new Polyline();
  }
  
  Polyline get polyline => _polyline;

  @NgOneWay('gmap')
  set gMap(GMap gMap) {
    _gMap = gMap;
    _polyline.map = _gMap;
  }

  @NgAttr('stroke-color')
  set strokeColor(String strokeColor) {
    _strokeColor = strokeColor;
    _polyline.options = new PolylineOptions()..strokeColor = _strokeColor;
  }

  @NgOneWay('visible')
  set visible(bool visible) {
    _visible = visible;
    _polyline.visible = _visible;
  }

  @NgOneWay('editable')
  set editable(bool editable) {
    _editable = editable;
    _polyline.editable = _editable;
  }

  Function _pathChange;
  Function _insertAt;
  Function _setAt;
  Function _removeAt;
  //TODO review : Experimental
  @NgTwoWay('path')
  set path(ObservableList<LatLngWrapper> path) {
    _path = path;
    if (_onInsertAt != null) {
      _onInsertAt.cancel();
      _onSetAt.cancel();
      _onRemoveAt.cancel();
      _onPathChange.cancel();
    }
    _polyline.path.clear();
    if (_path != null) {
      _path.forEach((latLngWrapper) {
        _polyline.path.push(latLngWrapper.latLng);
      });
      _insertAt = (i) {
        //print("dec insert");
        _onPathChange.cancel();
        _path.insert(i, new LatLngWrapper.fromLatLng(_polyline.path.getAt(i)));
        _onPathChange = _path.listChanges.listen(_pathChange);
      };
      _setAt = (IAE) {
        //print("dec set");
        _onPathChange.cancel();
        _path[IAE.index] = new LatLngWrapper.fromLatLng(_polyline.path.getAt(IAE.index));
        _onPathChange = _path.listChanges.listen(_pathChange);
      };
      _removeAt = (IAE) {
        //print("dec remove");
        _onPathChange.cancel();
        _path.removeAt(IAE.index);
        _onPathChange = _path.listChanges.listen(_pathChange);
      };
      _onInsertAt = _polyline.path.onInsertAt.listen(_insertAt);
      _onSetAt = _polyline.path.onSetAt.listen(_setAt);
      _onRemoveAt = _polyline.path.onRemoveAt.listen(_removeAt);
      _pathChange = (List<ListChangeRecord> records) {
        records.forEach((ListChangeRecord record) {
          //Insert
          if (record.removed.isEmpty && record.addedCount > 0) {
            //print("insert");
            _onInsertAt.cancel();
            for(int i = 0;i<record.addedCount;i++){
              _polyline.path.insertAt(record.index+i, _path[record.index+i].latLng);  
            }
            _onInsertAt = _polyline.path.onInsertAt.listen(_insertAt);
          }
          //Update
          if (!record.removed.isEmpty && record.addedCount > 0) {
            //print("update");
            _onSetAt.cancel();
            _polyline.path.setAt(record.index, _path[record.index].latLng);
            _onSetAt = _polyline.path.onSetAt.listen(_setAt);
          }
          //Remove
          if (!record.removed.isEmpty && record.addedCount == 0) {
            //print("remove");
            _onRemoveAt.cancel();
            _polyline.path.removeAt(record.index);
            _onRemoveAt = _polyline.path.onRemoveAt.listen(_removeAt);
          }
        });
      };
      _onPathChange = _path.listChanges.listen(_pathChange);
    }
  }
  get path => _path;

  @NgOneWay('remove-point-on-rightclick')
  set removePointOnRightclick(bool removePointOnRightclick) {
    _removePointOnRightclick = removePointOnRightclick;
    if (_removePointOnRightclick) {
      _polyline.onRightclick.listen((e) {
        _path.removeWhere((latLng) {
          return e.latLng.equals(latLng.latLng);
        });
        onRightclick({
          "\$polyline": _polyline
        });
      });
    } else {
      _polyline.onRightclick.listen((e) {
        onRightclick({
          "\$polyMouseEvent": e
        });
      });
    }
  }

  attach() {
    _polyline.onClick.listen((e) {
      onClick({
        "\$polyline": _polyline
      });
    });
    _polyline.onDblclick.listen((e) {
      onDblClick({
        "\$latLngWrapper": _path.firstWhere((latLngWrapper) => e.latLng.lat == latLngWrapper.lat && e.latLng.lng == latLngWrapper.lng, orElse: () => null)
      });
    });
    _polyline.onMouseover.listen((e) {
      onMouseover({
        "\$polyMouseEvent": e
      });
    });
    _polyline.onMouseout.listen((e) {
      onMouseout({
        "\$polyMouseEvent": e
      });
    });
  }

  detach() {
    _polyline.map = null;
  }

}
