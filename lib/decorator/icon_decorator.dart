part of decorator;

@Decorator(selector: '[icon]')
class IconDecorator implements AttachAware, DetachAware {

  Icon _icon;
  String _url;
  Size _scaledSize;
  @NgCallback('on_created')
  Function onCreated;

  IconDecorator(){
    _icon = new Icon();
  }
  
  get icon => _icon;

  //TODO inspect @NgAttr('url') called when no attr
  //@NgOneWay('url')
  @NgAttr('url')
  set url(String url){
    _url = url;
    _icon.url = url;
  }

  @NgOneWay('scaled-size')
  set scaledSize(Size scaledSize){
    _scaledSize = scaledSize;
    _icon.scaledSize = scaledSize;
  }

  attach() {
    onCreated({"\$icon" : _icon});
  }

  detach() {
    _icon = null;
  }

}
