import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/constants/constant_borders.dart';
import 'package:food_for_health/core/general_widgets/custom_date_picker.dart';
import 'package:food_for_health/core/general_widgets/toast_messages.dart';
import 'package:food_for_health/core/models/cache_user.dart';
import 'package:food_for_health/core/models/disease.dart';
import 'package:food_for_health/core/models/user_diseases.dart';
import 'package:food_for_health/features/profile/view_model/user_diseases_state.dart';
import 'package:food_for_health/features/profile/view_model/user_diseases_view_model.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

// ignore: must_be_immutable
class UserDiseasesCard extends StatefulWidget {
  UserDiseasesCard({super.key, required this.cacheUser, required this.userDiseasesViewModel});

  CacheUser? cacheUser;
  UserDiseasesViewModel userDiseasesViewModel;

  @override
  State<UserDiseasesCard> createState() => _UserDiseasesCardState();
}

class _UserDiseasesCardState extends State<UserDiseasesCard> {
  List<Disease> diseases = [];
  List<DropdownMenuEntry<String>> dropdownMenuEntries = [];
  String? selectedDiseaseId;
  String? selectedDiseaseName;
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  TextEditingController diseaseNotesController = TextEditingController();

  Future<void> fetchDiseases() async {
    try {
      List<Disease> fetchedDiseases = await widget.userDiseasesViewModel.getDiseases();
      setState(() {
        diseases = fetchedDiseases;
        dropdownMenuEntries = diseases
            .map((disease) => DropdownMenuEntry<String>(
                  value: disease.id.toString(),
                  label: disease.diseaseName,
                ))
            .toList();
      });
    } catch (e) {
      throw Exception("Bir hata oluştu : ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDiseasesViewModel, UserDiseasesState>(builder: (context, state) {
      return Expanded(
        child: Card(
          color: Color(0xFFFFDAD9),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Hastalıklarım", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await fetchDiseases();

                              if (context.mounted) {
                                createUserDiseaseMBS(context);
                              }
                            },
                            icon: Icon(
                              FontAwesomeIcons.plus,
                              size: 20,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              if (state is UserDiseasesLoadingState)
                Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.appsMainColor)))
              else if (state is UserDiseasesErrorState)
                Text(state.errorMessage)
              else if (state is UserDiseasesLoadedState)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.userDiseases.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var disease = state.userDiseases[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Hastalık Bilgileri"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text("Hastalık Adı : ${disease.diseaseName}"),
                                    Text("Hastalık Notu : ${disease.notes}"),
                                    Text(
                                        "Hastalık Başlangıç Tarihi\n${DateFormat("dd/MM/yyyy").format(disease.startDate)}"),
                                    Text(
                                        "Hastalık Eklenme Tarihi\n${DateFormat("dd/MM/yyyy").format(disease.dateAdded)}"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Kapat"))
                                ],
                              );
                            },
                          ),
                          child: Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(disease.diseaseName.toString()),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.warning,
                                                title: "Hastalığı siliyorsunuz..",
                                                text: "Hastalığı silmek istediğinizden emin misiniz?",
                                                showCancelBtn: true,
                                                showConfirmBtn: true,
                                                cancelBtnText: "Vazgeç",
                                                confirmBtnText: "Sil",
                                                confirmBtnColor: Colors.red,
                                                onConfirmBtnTap: () async {
                                                  bool isDeleted = await widget.userDiseasesViewModel
                                                      .deleteUserDisease(disease.id);
                                                  if (context.mounted) Navigator.pop(context);
                                                  if (isDeleted && context.mounted) {
                                                    widget.userDiseasesViewModel
                                                        .getUserDiseases(widget.cacheUser!.userID);
                                                    ToastMessages()
                                                        .showSuccessToast(context, "Hastalık silindi.");
                                                  } else {
                                                    if (context.mounted) {
                                                      ToastMessages()
                                                          .showErrorToast(context, "Hastalık silinemedi.");
                                                    }
                                                  }
                                                });
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.trash,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.chevronRight,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                )
              else
                SizedBox.shrink()
            ],
          ),
        ),
      );
    });
  }

  Future<dynamic> createUserDiseaseMBS(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("Hastalık Seçiniz"),
                    DropdownMenu(
                      menuHeight: 200,
                      width: MediaQuery.of(context).size.width,
                      dropdownMenuEntries: dropdownMenuEntries,
                      /* initialSelection: dropdownMenuEntries.first.value, */
                      onSelected: (value) {
                        selectedDiseaseId = value;
                        selectedDiseaseName =
                            diseases.firstWhere((d) => d.id.toString() == value).diseaseName;
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("Hastalık Başlangıç Tarihi"),
                    CustomDatePicker(icon: FontAwesomeIcons.calendarDay, selectedDate: selectedDate)
                  ],
                ),
                TextFormField(
                    controller: diseaseNotesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: ConstantBorders.mbsTextFieldBorder,
                        enabledBorder: ConstantBorders.mbsTextFieldBorder,
                        focusedBorder: ConstantBorders.mbsTextFieldBorder,
                        hintText: "Hastalıkla ilgili notlarınızı giriniz")),
                ElevatedButton(
                  onPressed: () async {
                    bool isCreateDone = await widget.userDiseasesViewModel.createUserDisease(UserDisease(
                        id: 0,
                        userID: widget.cacheUser!.userID,
                        diseaseID: int.parse(selectedDiseaseId!),
                        diseaseName: selectedDiseaseName!,
                        notes: diseaseNotesController.text.isNotEmpty ? diseaseNotesController.text : "",
                        startDate: selectedDate.value,
                        dateAdded: DateTime.now()));
                    if (context.mounted) Navigator.pop(context);
                    if (isCreateDone && context.mounted) {
                      widget.userDiseasesViewModel.getUserDiseases(widget.cacheUser!.userID);
                      ToastMessages().showSuccessToast(context, "Hastalık eklendi.");
                    } else {
                      if (context.mounted) {
                        ToastMessages().showErrorToast(context, "Hastalık eklenemedi.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      backgroundColor: AppColors.appsMainColor,
                      fixedSize: Size.fromWidth(MediaQuery.of(context).size.width)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Hastalığı Ekle",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
