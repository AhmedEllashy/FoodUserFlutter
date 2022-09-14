import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/user_bloc/user_cubit.dart';
import 'package:food_user/domain/models/user.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';

class UserPreferencesView extends StatefulWidget {
  const UserPreferencesView({Key? key}) : super(key: key);

  @override
  State<UserPreferencesView> createState() => _UserPreferencesViewState();
}

class _UserPreferencesViewState extends State<UserPreferencesView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? myPickedImage;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    UserCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s12),
          child: ListView(
            children: [
              topBarSection(AppStrings.preferences, context),
              BlocConsumer<UserCubit, UserState>(
                listener: (context,state){
                  if(state is UpdateUserDataFailedState){
                    getFlashBar(state.error, context);
                  }
                  else if(state is UpdateUserDataCompletedState){
                    getFlashBar("User Data Updated Successfully", context,backgroundColor: AppColors.green);
                    Navigator.of(context).pop();

                  }
                },
                builder: (context, state) {
                  if (state is GetUserDataCompletedState) {
                    final user = state.user;
                    _nameController.text = user.name ?? "";
                    _emailController.text = user.email ?? "";
                    _phoneNumberController.text = user.phoneNumber ?? "";
                    return Column(
                      children: [
                        _imageSection(user),
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        _bottomFieldsSection(user, state),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageSection(UserDataModel user) {
    return InkWell(
      onTap: () {
        pickImage();
      },
      child: Container(
        height: AppSize.s100,
      width: AppSize.s100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s30),

      ),
        // clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            myPickedImage == null ?ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s60),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: user.imageUrl ?? "",
                placeholder: (context, url) => Image.asset(
                  AppAssets.userIcon,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset(AppAssets.userIcon, fit: BoxFit.cover),
              ),
            ):CircleAvatar(
              backgroundImage: AssetImage(myPickedImage!.path),
              radius: 60,
            ),
            Positioned(
                bottom: 10,
                right: 25,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.white,
                  size: AppSize.s30,
                )),
          ],
        ),
      ),
    );
  }

  Widget _bottomFieldsSection(UserDataModel user, state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
            _nameController,
            Icon(Icons.person),
            hasBorder: true,
            hint: AppStrings.name,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          AppTextFormField(
            _emailController,
            Icon(Icons.mail),
            hasBorder: true,
            hint: AppStrings.email,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          AppTextFormField(
            _phoneNumberController,
            Icon(Icons.phone_android),
            hasBorder: true,
            hint: AppStrings.phoneNumber,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          state is UpdateUserDataLoadingStateState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : AppButton(AppStrings.save, () async {
                  if (_formKey.currentState!.validate()) {
                   user.imageUrl!.isEmpty && myPickedImage != null ? await uploadImage(user.uid!):null;
                    UserCubit.get(context).updateUserData(
                        imageUrl ?? user.imageUrl!,
                        _emailController.text,
                        _nameController.text,
                        _phoneNumberController.text);
                  }

                }),
        ],
      ),
    );
  }

  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      myPickedImage = File(pickedImage!.path);
    });
  }

  Future<void> uploadImage(String uid) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('/users/${uid}');
    TaskSnapshot uploadImage = await reference.putFile(myPickedImage!);
    String url = await uploadImage.ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }
}
