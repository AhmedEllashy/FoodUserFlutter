import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/product_bloc/product_state.dart';

import '../../domain/logic/product_bloc/product_cubit.dart';
import '../product_details/product_details_view.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../resources/widgets_manager.dart';

class MostPopularProductsView extends StatefulWidget {
  const MostPopularProductsView({Key? key}) : super(key: key);

  @override
  State<MostPopularProductsView> createState() => _MostPopularProductsViewState();
}

class _MostPopularProductsViewState extends State<MostPopularProductsView> {
  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }
  Widget _getContentScreen(){
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<ProductCubit,ProductState>(
        listener: (context,state){},
        builder: (context,state)=>SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s20),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _topBarSection(),
                const  SizedBox(height: AppSize.s35,),
                state is GetAllProductCompletedState
                    ? _mostPopularProductsSection(state)
                    : state is GetAllProductLoadingState
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : const Text(AppStrings.noData),

              ],
            ),
          ),
        ),

      ),
    );
  }
  Widget _topBarSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //     Navigator.pop(context);
        // debugPrint('Tapped');
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: AppSize.s45,
            width: AppSize.s45,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSize.s14),
            ),
            child: const Center(
              child:  Icon(
                Icons.arrow_back_ios_new,
                textDirection: TextDirection.ltr,
                size: AppSize.s18,
                color: AppColors.black,
              ),
            ),
          ),
        ),
        Text(
          AppStrings.mostPopular,
          style: getBoldTextStyle(color: AppColors.grey),
        ),
      ],
    );
  }
  Widget _mostPopularProductsSection(GetAllProductCompletedState state) {
    final products = state.products;
    return Container(
      color: AppColors.backgroundColor,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppSize.s2.toInt(),
              childAspectRatio: 2 / 3.6,
              mainAxisSpacing: AppSize.s30,
              crossAxisSpacing: AppSize.s10),
          itemBuilder: (context, index) {
            return InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetailsView(
                id: products[index].id!,
                prodName: products[index].name!,
                category:products[index].category! ,
                price: products[index].price!,
                discount: products[index].discount!,
                imageUrl: products[index].imageUrl!,
                status: products[index].status!,
                amount: products[index].amount!,
                deliveryTime: products[index].deliveryTime!,
                description: products[index].description!,
              )));
            },child:  GetProductWidget(
              (){

              },
            product: products[index],
            ));
          }),
    );
  }

}
