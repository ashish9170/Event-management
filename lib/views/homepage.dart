import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:partypilot/auth.dart';
import 'package:partypilot/constants/colors.dart';
import 'package:partypilot/containers/event_container.dart';
import 'package:partypilot/database.dart';
import 'package:partypilot/saved_data.dart';
import 'package:partypilot/views/create_event_page.dart';
import 'package:partypilot/views/event_detail.dart';
import 'package:partypilot/views/login.dart';
import 'package:partypilot/views/profile_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String userName = "User";
  List<Document> events = [];
  bool isLoading = true;

  @override
  void initState() {
    userName = SavedData.getUserName().split(" ")[0];
    refresh();
    super.initState();
  }

  void refresh() {
    getAllEvents().then((value) {
      events = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              logoutUser();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: Icon(
              Icons.account_circle,
              color: kLightGreen,
              size: 30,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi Attendee 👋 ${userName}",
                    style: TextStyle(color: kLightGreen, fontSize: 32, fontWeight: FontWeight.w300),
                  ),
                  Text("Explore event around you",style: TextStyle(color: kLightGreen, fontSize: 16, fontWeight: FontWeight.w300))
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>EventContainer(data:events[index]),
              childCount: events.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEventPage()));
          refresh();
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: kLightGreen,
      ),
    );
  }
}
