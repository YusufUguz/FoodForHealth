import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_for_health/core/general_widgets/secure_storage_manager.dart';
import 'package:food_for_health/core/models/cache_user.dart';
import 'package:food_for_health/features/profile/view/widgets/user_base_info_card.dart';
import 'package:food_for_health/features/profile/view/widgets/user_diseases_card.dart';
import 'package:food_for_health/features/profile/view/widgets/personal_infos_card.dart';
import 'package:food_for_health/features/profile/view_model/user_diseases_view_model.dart';
import 'package:food_for_health/features/profile/view_model/user_info_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  SecureStorageManager ssm = SecureStorageManager();
  ValueNotifier<CacheUser?> cacheUser = ValueNotifier(null);
  late UserInfoViewModel userInfoViewModel;
  late UserDiseasesViewModel userDiseasesViewModel;
  ValueNotifier<String> gender = ValueNotifier("");

  getCacheUserAndInfos() async {
    CacheUser? user = await ssm.getUserInfo();
    cacheUser.value = user;
    userInfoViewModel.getUserInfos(user.userID);
    userDiseasesViewModel.getUserDiseases(user.userID);
  }

  @override
  void initState() {
    super.initState();
    userInfoViewModel = UserInfoViewModel(context);
    userDiseasesViewModel = UserDiseasesViewModel(context);
    getCacheUserAndInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => userInfoViewModel),
          BlocProvider(create: (context) => userDiseasesViewModel)
        ],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            spacing: 5,
            children: [
              ValueListenableBuilder(
                  valueListenable: gender,
                  builder: (context, genderValue, child) {
                    return UserBaseInfoCard(
                      cacheUser: cacheUser,
                      gender: genderValue,
                    );
                  }),
              ValueListenableBuilder(
                  valueListenable: cacheUser,
                  builder: (context, cacheUserValue, child) {
                    return PersonalInfosCard(
                        gender: gender, userInfoViewModel: userInfoViewModel, cacheUser: cacheUserValue);
                  }),
              ValueListenableBuilder(
                  valueListenable: cacheUser,
                  builder: (context, cacheUserValue, child) {
                    return UserDiseasesCard(
                        userDiseasesViewModel: userDiseasesViewModel, cacheUser: cacheUserValue);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
