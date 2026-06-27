import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/constants/constant_borders.dart';
import 'package:food_for_health/core/general_widgets/custom_date_picker.dart';
import 'package:food_for_health/core/general_widgets/toast_messages.dart';
import 'package:food_for_health/core/models/cache_user.dart';
import 'package:food_for_health/core/models/user_info.dart';
import 'package:food_for_health/features/profile/view/widgets/personal_infos_single_card.dart';
import 'package:food_for_health/features/profile/view_model/user_info_state.dart';
import 'package:food_for_health/features/profile/view_model/user_info_view_model.dart';
import 'package:intl/intl.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

// ignore: must_be_immutable
class PersonalInfosCard extends StatelessWidget {
  PersonalInfosCard(
      {super.key, required this.gender, required this.userInfoViewModel, required this.cacheUser});

  final ValueNotifier<String> gender;
  final UserInfoViewModel userInfoViewModel;
  CacheUser? cacheUser;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> genderDropDownList = <String>['Erkek', 'Kadın'];
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  List<MenuEntry> get menuEntries =>
      genderDropDownList.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)).toList();
  ValueNotifier<String> selectedGender = ValueNotifier('Erkek');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoViewModel, UserInfoState>(builder: (context, state) {
      if (state is UserInfoLoadedState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          gender.value = state.userInfo.gender;
        });
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height * 1.2 / 3,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Color(0xFFE8F0FE),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Kişisel Bilgilerim", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (state is UserInfoErrorState) {
                                if (state.errorMessage == "Kullanıcı bilgisi bulunamadı.") {
                                  createUserInfoMBS(context, "create", null);
                                } else {
                                  return;
                                }
                              }
                            },
                            icon: Icon(
                              FontAwesomeIcons.plus,
                              size: 18,
                            )),
                        IconButton(
                            onPressed: () {
                              if (state is UserInfoLoadedState) {
                                createUserInfoMBS(context, "edit", state.userInfo);
                              } else {
                                return;
                              }
                            },
                            icon: Icon(FontAwesomeIcons.penToSquare, size: 18)),
                      ],
                    ),
                  ],
                ),
              ),
              if (state is UserInfoLoadingState)
                Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.appsMainColor)))
              else if (state is UserInfoErrorState)
                Center(child: Text(state.errorMessage))
              else if (state is UserInfoLoadedState)
                GridView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 1.6),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    PersonalInfosSingleCard(
                      iconPath: "assets/icons/height.png",
                      cardText: "${state.userInfo.height.toString()} cm",
                    ),
                    PersonalInfosSingleCard(
                      iconPath: "assets/icons/weight.png",
                      cardText: "${state.userInfo.weight.toString()} kg",
                    ),
                    PersonalInfosSingleCard(
                      iconPath: "assets/icons/gender.png",
                      cardText: state.userInfo.gender,
                    ),
                    PersonalInfosSingleCard(
                      iconPath: "assets/icons/birth_date.png",
                      cardText: DateFormat("dd/MM/yyyy").format(state.userInfo.birthDate),
                    )
                  ],
                )
            ],
          ),
        ),
      );
    });
  }

  Future<dynamic> createUserInfoMBS(BuildContext context, String mbsType, UserInfo? stateUserInfo) {
    if (mbsType == "edit" && stateUserInfo != null) {
      heightController.text = stateUserInfo.height.toString();
      weightController.text = stateUserInfo.weight.toString();
      selectedDate.value = stateUserInfo.birthDate;
    } else {
      heightController.text = ""; // Clear for create mode
      weightController.text = "";
    }
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 15,
                children: [
                  SizedBox(height: 10),
                  HeightTextfield(heightController: heightController),
                  WeightTextfield(weightController: weightController),
                  ValueListenableBuilder(
                    valueListenable: selectedGender,
                    builder: (context, selectedGenderValue, snapshot) {
                      return DropdownMenu<String>(
                        width: double.infinity,
                        initialSelection: genderDropDownList.first,
                        leadingIcon: Icon(FontAwesomeIcons.venusMars),
                        onSelected: (String? value) {
                          selectedGender.value = value!;
                        },
                        dropdownMenuEntries: menuEntries,
                      );
                    },
                  ),
                  CustomDatePicker(icon: FontAwesomeIcons.cakeCandles, selectedDate: selectedDate),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool isCreateDone = await userInfoViewModel.createUserInfo(UserInfo(
                            id: mbsType == "create" ? 0 : stateUserInfo!.id,
                            userID: cacheUser!.userID,
                            nameSurname: cacheUser!.fullName,
                            height: int.parse(heightController.text),
                            weight: int.parse(weightController.text),
                            gender: selectedGender.value,
                            birthDate: selectedDate.value));
                        if (context.mounted) Navigator.pop(context);
                        if (isCreateDone && context.mounted) {
                          userInfoViewModel.getUserInfos(cacheUser!.userID);
                          ToastMessages().showSuccessToast(
                              context,
                              mbsType == "create"
                                  ? "Kişisel bilgileriniz oluşturuldu."
                                  : "Kişisel bilgileriniz güncellendi.");
                        } else {
                          if (context.mounted) {
                            ToastMessages().showErrorToast(
                                context,
                                mbsType == "create"
                                    ? "Kişisel bilgileriniz oluşturulamadı."
                                    : "Kişisel bilgileriniz güncellenemedi.");
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        backgroundColor: AppColors.appsMainColor,
                        fixedSize: Size.fromWidth(MediaQuery.of(context).size.width)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        mbsType == "create" ? "Kişisel Bilgilerimi Oluştur" : "Kişisel Bilgilerimi Güncelle",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class WeightTextfield extends StatelessWidget {
  const WeightTextfield({
    super.key,
    required this.weightController,
  });

  final TextEditingController weightController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: weightController,
      validator: (value) {
        final weight = int.tryParse(value!);
        if (value.isEmpty) {
          return "Boş Bırakılamaz.";
        } else if (weight! <= 0 || weight > 300) {
          return "Geçerli bir kilo giriniz. (0-300 kg).";
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(FontAwesomeIcons.weightScale),
          border: ConstantBorders.mbsTextFieldBorder,
          focusedBorder: ConstantBorders.mbsTextFieldBorder,
          enabledBorder: ConstantBorders.mbsTextFieldBorder,
          hintText: "Kilonuz (kg)"),
    );
  }
}

class HeightTextfield extends StatelessWidget {
  const HeightTextfield({
    super.key,
    required this.heightController,
  });

  final TextEditingController heightController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: heightController,
      validator: (value) {
        final height = int.tryParse(value!);
        if (value.isEmpty) {
          return "Boş Bırakılamaz.";
        } else if (height! <= 0 || height > 250) {
          return "Geçerli bir boy giriniz. (0-250 cm).";
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(FontAwesomeIcons.person),
          border: ConstantBorders.mbsTextFieldBorder,
          focusedBorder: ConstantBorders.mbsTextFieldBorder,
          enabledBorder: ConstantBorders.mbsTextFieldBorder,
          hintText: "Boyunuz (cm)"),
    );
  }
}
