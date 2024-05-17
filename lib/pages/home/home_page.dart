import '../../lib.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // chat & auth services
  final ChatService chatServices = ChatService();

  final AuthServices authServices = AuthServices();

  bool isAddPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isAddPressed
          ? AppBar(
              title: const Text('Home Page'),
              actions: [
                IconButton(
                  onPressed: () {
                    // authServices.signOut();
                    isAddPressed = !isAddPressed;
                    ChatService().getChatRoom();
                    setState(() {});
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          : AppBar(
              title: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add User',
                  fillColor: Colors.grey.shade300,
                  filled: true,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // authServices.signOut();
                    isAddPressed = !isAddPressed;
                    setState(() {});
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    // authServices.signOut();
                    isAddPressed = !isAddPressed;
                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: chatServices.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No users found'));
          }
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: ListView(
              children: snapshot.data!.isNotEmpty
                  ? snapshot.data!
                      .map<Widget>(
                          (userData) => _buildUserListItem(userData, context))
                      .toList()
                  : [
                      const Center(
                        child: Text(
                          'No users found',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
            ),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != authServices.currentUser!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          debugPrint('sending message to ${userData['email']}');
          Get.to(() => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
