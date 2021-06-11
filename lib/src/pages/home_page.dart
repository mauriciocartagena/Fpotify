import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(''),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        // user.login,
                        'Mauricio',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // SliverList(
            //   delegate: SliverChildListDelegate([
            //     Container(
            //       height: 600,
            //       child: users != null
            //           ? ListView.builder(
            //               scrollDirection: Axis.vertical,
            //               itemCount: users.length,
            //               itemBuilder: (context, index) {
            //                 return Container(
            //                   padding: EdgeInsets.all(15),
            //                   decoration: BoxDecoration(
            //                       border: Border(
            //                           bottom:
            //                               BorderSide(color: Colors.grey[200]))),
            //                   child: Row(
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: <Widget>[
            //                       Row(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                         children: <Widget>[
            //                           Container(
            //                             width: 60,
            //                             height: 60,
            //                             child: CircleAvatar(
            //                               backgroundImage:
            //                                   NetworkImage(user.htmlUrl),
            //                             ),
            //                           ),
            //                           SizedBox(
            //                             width: 10,
            //                           ),
            //                           Text(
            //                             users[index].login,
            //                             style: TextStyle(
            //                                 fontSize: 20,
            //                                 color: Colors.grey[700]),
            //                           ),
            //                         ],
            //                       ),
            //                       Text(
            //                         'Following',
            //                         style: TextStyle(color: Colors.blue),
            //                       )
            //                     ],
            //                   ),
            //                 );
            //               },
            //             )
            //           : Container(
            //               child: Align(child: Text('Data is loading ...'))),
            //     )
            //   ]),
            // )
          ],
        ),
      ),
    );
  }
}
