import '../../models/banner.dart';

abstract class BannerState{}

class BannerInitialState extends BannerState{}
class GetAllBannersCompletedState extends BannerState{
  List<BannerModel> banners = [];
  GetAllBannersCompletedState(this.banners);
}
class GetAllBannersLoadingState extends BannerState{}
class GetAllBannersFailedState extends BannerState{
  String message;
  GetAllBannersFailedState(this.message);
}