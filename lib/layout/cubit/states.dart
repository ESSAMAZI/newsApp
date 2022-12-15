abstract class NewsStates {}

class NewsInitialsState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessstate extends NewsStates {}

class NewsGetBusinessErrorstate extends NewsStates {
  final String error;
  //ارجع الخطى
  NewsGetBusinessErrorstate(this.error);
}

class NewsGetSPortsLoadingState extends NewsStates {}

class NewsGetSPortsSuccessstate extends NewsStates {}

class NewsGetSPortsErrorstate extends NewsStates {
  final String error;
  //ارجع الخطى
  NewsGetSPortsErrorstate(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessstate extends NewsStates {}

class NewsGetScienceErrorstate extends NewsStates {
  final String error;
  //ارجع الخطى
  NewsGetScienceErrorstate(this.error);
}

//الثيم
class NewsAppChangeModeState extends NewsStates {}

//البحث
class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessstate extends NewsStates {}

class NewsGetSearchErrorstate extends NewsStates {
  final String error;
  //ارجع الخطى
  NewsGetSearchErrorstate(this.error);
}
