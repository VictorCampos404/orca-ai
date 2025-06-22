import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/data/data.dart';
import 'package:signature/signature.dart';

class UserController extends ChangeNotifier {
  late SignatureController signatureController;

  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;

  late bool _isLoading;
  bool get isLoading => _isLoading;

  late UserDto? _userData;
  UserDto? get userData => _userData;

  bool get hasUser => _userData != null;

  bool get canSaveUser {
    return nameCtrl.text.isNotEmpty &&
        phoneCtrl.text.isNotEmpty &&
        signatureController.isNotEmpty;
  }

  UserController() {
    reset();
  }

  void reset() {
    signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: AppColors.text,
      exportPenColor: Colors.black,
      exportBackgroundColor: Colors.white,
      strokeCap: StrokeCap.round,
      onDrawEnd: () {
        updateStatus();
      },
    );
    nameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    _userData = null;

    notifyListeners();
  }

  void updateStatus() {
    notifyListeners();
  }

  void initialize() async {
    _userData = null;
    notifyListeners();
  }

  Future<void> saveData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final newUser = UserDto(
        name: nameCtrl.text,
        phone: phoneCtrl.text,
        signature: signatureController.points,
      );

      // await _localConfigSerivce.setUser(newUser);

      _userData = newUser;

      // Directory appDocumentsDir = await getApplicationDocumentsDirectory();

      // final file = File("${appDocumentsDir.path}/signature.png");

      // final bytes = await signatureController.toPngBytes();

      // if (bytes != null) {
      //   await file.writeAsBytes(bytes);
      // }
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
