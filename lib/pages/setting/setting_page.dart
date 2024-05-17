import '../../lib.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: GetBuilder<SettingController>(initState: (state) {
        controller.idController.text = AuthServices.instance.currentUser!.uid;
      }, builder: (_) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.idController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey.withOpacity(0.3),
                      filled: true,
                      enabled: false,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(controller.idController.text).then(
                      (value) => debugPrint('copied'),
                    );
                  },
                  icon: const Icon(Icons.copy),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
