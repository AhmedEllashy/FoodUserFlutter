import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/banner_bloc/banner_state.dart';

import '../../../data/Repository/repository.dart';
import '../../models/banner.dart';

class BannerCubit extends Cubit<BannerState> {
  final Repository _repository;
  List<BannerModel> banners = [];
  BannerCubit(this._repository) : super(BannerInitialState());
  static BannerCubit get(context) => BlocProvider.of<BannerCubit>(context);

  List<BannerModel> getAllBanners() {
    emit(GetAllBannersLoadingState());
    _repository.getAllBanners().then(
      (banners) {
        emit(GetAllBannersCompletedState(banners));
        this.banners = banners;
        debugPrint("banners : $banners");
      },
      onError: (e) {
        emit(GetAllBannersFailedState(e.toString()));
      },
    );
    return banners;
  }
}
