import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'customappbar.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id;   String fieldname="Company Name";
  String fieldvalue="";
  List<User> _users=List<User>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();

//_getEventsFromFirestore();
  getData(fieldname,fieldvalue);
}
 int i=0;
  getData(fieldname,fieldvalue){
    _users.clear();

   Firestore.instance.collection("test").where(fieldname, isEqualTo: fieldvalue).getDocuments().then((value){

   if(value.documents.length>0) {
     value.documents.forEach((element) {
       User u=User();
       //element.data["First Name"].toString(), element.data["Gender"].toString(), element.data["Company Name"].toString(), element.data["Job Title"].toString()
u.name=element.data["First Name"].toString();
u.gender=element.data["Gender"].toString();
u.company_name=element.data["Company Name"].toString();
u.position=element.data["Job Title"].toString();
      setState(() {

        _users.add(u);
      });
      return (element.data.values.toString());
     });
   }
   else{
     i++;
     if(i==1) {
       fieldname = "Gender";

       getData(fieldname, fieldvalue);
     }
     else if(i==2){

       fieldname = "First Name";
       getData(fieldname, fieldvalue);
     }
     else if(i==3){
       fieldname = "Last Name";
       getData(fieldname,fieldvalue);
     }

     else if(i==4){
       fieldname = "User ID";
       getData(fieldname, fieldvalue);
     }

     else if(i==5){
       fieldname = "Job Title";
       getData(fieldname, fieldvalue);
     }
     // else{
     //   return "No data";
     // }

   }
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        submitButtonText: "Search",

        onActionPressed:(){
          if(fieldvalue!=null||fieldvalue.isNotEmpty) {
            i=0;
            getData(fieldname,fieldvalue);
          }
          },

        //       icon: AppIcon.settings,
        //     onActionPressed: onSettingIconPressed,
        onSearchChanged: (text) {
          setState(() {
            fieldvalue=text;
          });
        //  state.filterByUsername(text);
        },
        actions: [



        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: Icon(
                      Icons.list,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 30),
                    child: Text(
                      "Drawer",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.orangeAccent,
              ),
              title: Text(
                "Home Page",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
            ),
            Divider(
              height: 10,
              color: Colors.black,
              indent: 65,
            ),
            ListTile(
              leading: Icon(
                Icons.add_box,
                color: Colors.orangeAccent,
              ),
              title: Text(
                "Add Gadgets ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
               // Navigator.of(context).pushNamed(AddUser.routeName);
              },
            ),
            Divider(
              height: 10,
              indent: 65,
              color: Colors.black,
            ),
          ],
        ),
      ),

      body: ListView.builder(
    itemCount: _users==null?0:_users.length,
    itemBuilder: (context, index) {
    return ListTile(
    leading: CircleAvatar(
    child: Icon(Icons.person,color: Colors.white,),
    ),
    title: Text(_users[index].name),
    subtitle: Text(_users[index].company_name+" "+_users[index].position),
    trailing: Text(_users[index].gender),
    );
    },

    ));
  }
}
class User{
  String name;
  String gender;
  String company_name;
  String position;

  User();

}
