import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hair_cos/Constants/color.dart';
import 'package:hair_cos/Models/User.dart';
import 'package:hair_cos/Screens/Messages/chat.dart';

class Messages extends StatefulWidget {
  final String currentUserId;

  Messages({Key key, @required this.currentUserId}) : super(key: key);

  @override
  MessagesState createState() => MessagesState();
}

class MessagesState extends State<Messages> {
  bool isLoading = false;
  bool chat = true;
  String last;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // List
          Expanded(
            flex: 10,
            child: Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),

                      itemBuilder: (context, index) =>
                          mainScreen(context, snapshot.data.documents[index]),
                      // buildItem(context, snapshot.data.documents[index]),
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),
          ),

          // Loading
          Container(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Widget mainScreen(context, DocumentSnapshot document) {
    if (document['id'] == User.userData.userId) {
      return Container();
    } else {
      return UserTile(
        currentUserId: widget.currentUserId,
        doc: document,
      );
    }
  }
}

class UserTile extends StatefulWidget {
  final DocumentSnapshot doc;
  final String currentUserId;
  UserTile({@required this.doc, @required this.currentUserId});
  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  String last = '';
  String fromId = '';
  int seen;
  DateTime time;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    _fetch(widget.doc.documentID);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      peerId: widget.doc.documentID,
                      peerAvatar: widget.doc['profile_photo'],
                      peername: widget.doc['Name'],
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Material(
                        child: widget.doc['profile_photo'] != null &&
                                widget.doc['profile_photo'] != ''
                            ? CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        themeColor),
                                  ),
                                  width: 50.0,
                                  height: 50.0,
                                  padding: EdgeInsets.all(15.0),
                                ),
                                imageUrl: widget.doc['profile_photo'],
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.account_circle,
                                size: 50.0,
                                color: greyColor,
                              ),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        clipBehavior: Clip.hardEdge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${widget.doc['Name']}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('$last',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: fromId != widget.currentUserId && seen == 0
                            ? TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)
                            : null),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    time != null
                        ? '${time.hour}:${time.minute}:${time.second}'
                        : '',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  fromId != widget.currentUserId && seen == 0
                      ? CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 6,
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _fetch(String userId) async {
    String groupChatId;

    if (userId.hashCode <= widget.currentUserId.hashCode) {
      groupChatId = '$userId-${widget.currentUserId}';
    } else {
      groupChatId = '${widget.currentUserId}-$userId';
    }

    // Wait for each single message to arrive
    final m = await Firestore.instance
        .collection('messages')
        .document(groupChatId)
        .collection(groupChatId)
        .getDocuments();

    if (m.documents.length > 0) {
      setState(() {
        last = m.documents.last.data['content'];
        fromId = m.documents.last.data['idFrom'];
        seen = m.documents.last.data['seen'];
        time = DateTime.fromMillisecondsSinceEpoch(
            int.parse(m.documents.last.data['timestamp']));
      });
    } else {
      setState(() {
        last = '';
        seen = 1;
        time = null;
      });
    }
  }
}
