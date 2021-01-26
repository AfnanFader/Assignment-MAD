import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/model/pet.dart';
import 'package:assignment_project/model/request.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:assignment_project/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

<<<<<<< HEAD
class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin{

  TabController _tabController;
  Stream<List<Request>> _petListRequest;
  Stream<List<Request>> _petListRequestStatus;

  @override
  void initState() {
    UserNotifier notifier = Provider.of<UserNotifier>(context, listen: false);
    _tabController = TabController(vsync: this, length: 2);
    _petListRequest = DatabaseService().getPetPostRequest(notifier.getUserUID);
    _petListRequestStatus = DatabaseService().getPetPostRequest(notifier.getUserUID);
    super.initState();
  }
=======
class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatSearchTextController =
      TextEditingController();
  final _borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(17.5),
      borderSide: BorderSide(color: primarySwatch, width: 2));
>>>>>>> b0d63692d95b6d66de3e169fbb30f79019b26ee8

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    child: Container(
                    height: 35,
                    width: 120,
                    child: Center(
                        child: Text(
                      'ADOPT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 19),
                    )),
                    decoration: BoxDecoration(
                        color: primarySwatch,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(17.5),
                            bottomRight: Radius.circular(17.5))),
                  ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 19,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: primarySwatch,
                    labelColor: primarySwatch,
                    unselectedLabelColor: Colors.grey[500],
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        text: 'Approval',
                      ),
                      Tab(
                        text: 'Request',
                      )
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          child: StreamBuilder<List<Request>>(
                            stream: _petListRequest,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return _buildApproval(snapshot.data[index]);
                                  },
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey[350], thickness: 2,
                                  ),
                                );
                              } else {
                                return Container(
                                  child: Center(
                                    child: Text('You have no request'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          child: StreamBuilder<List<Request>>(
                            stream: _petListRequestStatus,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return _buildRequest(snapshot.data[index]);
                                  },
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey[350], thickness: 2,
                                  ),
                                );
                              } else {
                                return Container(
                                  child: Center(
                                    child: Text('Nothing'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  ListTile _buildApproval(Request data) {
    return ListTile(
      // shape: _borderDecoration,
      leading: CircleAvatar(
        backgroundImage: data.profilePic != null ?
        NetworkImage(data.profilePic) : null,
        child: data.profilePic != null ? Text('')
        : Text('${data.username[0].toUpperCase()}',
                style: TextStyle(
                    color: primarySwatch, fontSize: 35),
              ),
        radius: 25,
      ),
      title: Text(data.username),
      subtitle: Text('Requesting : ${data.petName}'),
      trailing: Container(
        // color: Colors.red,
        width: 80,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (data.status == 'Pending') ... {
              GestureDetector(
                onTap: () => DatabaseService().updateRequest(data, 'Approved'),
                child: CircleAvatar(
                  child: Icon(Icons.check, color: Colors.white),
                  backgroundColor: Colors.green,
                  radius: 15,
                ),
              ),
              SizedBox(width: 15,),
              GestureDetector(
                onTap: () => DatabaseService().updateRequest(data, 'Rejected'),
                child: CircleAvatar(
                  child: Icon(Icons.cancel_outlined, color: Colors.white),
                  backgroundColor: Colors.red,
                  radius: 15,
                ),
              ),
            } else ... {
               CircleAvatar(
                  child: Icon(Icons.done, color: Colors.white),
                  backgroundColor: Colors.blue,
                  radius: 15,
                ),
            }
          ],
        ),
      )
    );
  }

  ListTile _buildRequest(Request data) {
    return ListTile(
      // shape: _borderDecoration,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data.petImage),
        radius: 30,
=======
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _topPageTitle(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1))),
              child: ListTile(
                title: Text('Ayam Percik'),
                subtitle: Text('I want 3 chicken'),
                leading: CircleAvatar(
                  child: Text('A'),
                  radius: 23,
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '17/3/2020',
                      style: TextStyle(color: primarySwatch, fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: primarySwatch,
                      child: Text(
                        '20',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _topPageTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400])),
>>>>>>> b0d63692d95b6d66de3e169fbb30f79019b26ee8
      ),
      title: Text(data.petName),
      trailing: Container(
        // color: Colors.red,
        width: 160,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
<<<<<<< HEAD
            if (data.status == 'Approved') ... {
              Container(
                height: 30,
                padding: EdgeInsets.all(5),
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Approved',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            },
            if (data.status == 'Pending') ... {
              Container(
                height: 30,
                padding: EdgeInsets.all(5),
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
=======
            Container(
              height: 35,
              width: 110,
              child: Center(
                  child: Text(
                'CHATS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 19),
              )),
              decoration: BoxDecoration(
                  color: primarySwatch,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(17.5),
                      bottomRight: Radius.circular(17.5))),
            ),
            SizedBox(
              width: 100,
            ),
            Container(
              height: 35,
              width: 150,
              child: Center(
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: _chatSearchTextController,
                  decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(
                          color: primarySwatch, fontWeight: FontWeight.w300),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        Icons.search_sharp,
                        color: primarySwatch,
                      ),
                      enabledBorder: _borderDecoration,
                      focusedBorder: _borderDecoration),
>>>>>>> b0d63692d95b6d66de3e169fbb30f79019b26ee8
                ),
              ),
            },
            if (data.status == 'Rejected') ... {
              Container(
                height: 30,
                padding: EdgeInsets.all(5),
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Rejected',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            },
            SizedBox(width: 15,),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), 
                  border: Border.all(
                    width: 2,
                    color: primarySwatch
                  )
                ),
                padding: EdgeInsets.all(5),
                height: 30,
                child: Row(
                  children: [
                    Icon(Icons.phone, size: 15,color: primarySwatch,),
                    SizedBox(width: 5,),
                    Text(
                      'Call',
                      style: TextStyle(
                        color: primarySwatch,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      )
    );
  }
<<<<<<< HEAD

}
=======
}
>>>>>>> b0d63692d95b6d66de3e169fbb30f79019b26ee8
