import '../../models/banner.dart';

abstract class BannerStates{}

class BannerInitialState extends BannerStates{}
class GetAllBannersCompletedState extends BannerStates{
  List<BannerModel> banners = [];
  GetAllBannersCompletedState(this.banners);
}
class GetAllBannersLoadingState extends BannerStates{}
class GetAllBannersFailedState extends BannerStates{
  String message;
  GetAllBannersFailedState(this.message);
}