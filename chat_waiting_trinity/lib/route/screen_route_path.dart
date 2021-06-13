class ScreenRoutePath {
  final String title;
  final bool isUnknown;

  ScreenRoutePath.home()
      : title = null,
        isUnknown = false;

  ScreenRoutePath.details(this.title) : isUnknown = false;

  ScreenRoutePath.unKnown()
      : title = null,
        isUnknown = true;

  bool get isHomepage => title == null;

  bool get isDetailsPage => title != null;
}
