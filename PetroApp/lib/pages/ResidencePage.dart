import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:petroapp/models/ResidenceSearch.dart';
import 'package:petroapp/models/residence.dart';
import 'package:petroapp/services/FireBaseService.dart';
import 'package:petroapp/services/LoginService.dart';
import 'package:petroapp/services/Residenceselectedservice.dart';
import 'package:petroapp/widgets/residencebottombar.dart';
import 'package:petroapp/widgets/residencecard.dart';
import 'package:provider/provider.dart';

class ResidencePage extends StatefulWidget {
  @override
  State<ResidencePage> createState() => _ResidencePageState();
}

class _ResidencePageState extends State<ResidencePage> {
  List<Residence> residences = [];
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    ResidenceSelectedService resSelection =
        Provider.of<ResidenceSelectedService>(context, listen: false);
    FireBaseServices resService =
        Provider.of<FireBaseServices>(context, listen: true);
    LoginService loginService =
    Provider.of<LoginService>(context, listen: false);
    var userLoggedIn = loginService.loggedInUserModel?.uid;
    return Scaffold(
      appBar: AppBar(
        title: ClipOval(
          child: Container(
            child: Image.asset('assets/images/peter.png',
                fit: BoxFit.cover, scale: 10, alignment: Alignment.center),
            padding: EdgeInsets.all(9),
            margin: EdgeInsets.only(left: 97),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 1000),
                        dividerColor: Colors.red,
                        elevation: 1,
                        children: [
                          ExpansionPanel(
                            canTapOnHeader: true,
                            body: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 500,
                                    child: FirestoreSearchResults.builder(
                                      tag: 'searchRes',
                                      firestoreCollectionName: 'Residences',
                                      searchBy: 'Name',
                                      initialBody: const Center(child: Text('Здесь будут результаты поиска'),),
                                      dataListFromSnapshot:ResidenceS().dataListFromSnapshot,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final List<ResidenceS>? dataList = snapshot.data;
                                          if (dataList!.isEmpty) {
                                            return const Center(
                                              child: Text('Ничего не найдено'),
                                            );
                                          }
                                          return ListView.builder(
                                              itemCount: dataList.length,
                                              itemBuilder: (context, index) {
                                                final ResidenceS data = dataList[index];

                                                return Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder<DocumentSnapshot>(
                                                      future: resService.readRes(data.Id),
                                                      builder:
                                                          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                       if (snapshot.hasError) {
                                                          return Text("Something went wrong");
                                                        }

                                                        if (snapshot.hasData && !snapshot.data!.exists) {
                                                          return Text("Document does not exist");
                                                        }

                                                        if (snapshot.connectionState == ConnectionState.done) {
                                                          var res = Residence.fromJson(snapshot.data!.data()  as Map<String, dynamic>);
                                                          return ResidenceCard(
                                                              residence: res,
                                                              onCardClick: () {
                                                                resSelection.selectedResidence =
                                                                res;
                                                                Navigator.of(context)
                                                                    .pushNamed('/SelectedResidencePage');
                                                              });
                                                        }

                                                        return Text("Загрузка");
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: Text('Ничего не найдено'),
                                            );
                                          }
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            headerBuilder: (BuildContext context, bool isExpanded) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: FirestoreSearchBar(tag: "searchRes", clearSearchButtonColor: Colors.black, showSearchIcon: true,)
                              );
                            },
                            isExpanded: expand,
                          )
                        ],
                        expansionCallback: (int item, bool status) {
                          setState(() {
                            expand = !expand;
                          });
                        },
                      ),
                StreamBuilder<List<Residence>>(
                  stream: resService.getRes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var _residences = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                              padding: EdgeInsets.only(bottom: 100),
                              itemCount: _residences!.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Column(
                                  children: [
                                    ResidenceCard(
                                        residence: _residences[index],
                                        onCardClick: () {
                                          resSelection.selectedResidence =
                                              _residences[index];
                                          Navigator.of(context)
                                              .pushNamed('/SelectedResidencePage');
                                        }),
                                    Builder(
                                      builder: (BuildContext context){
                                            if(userLoggedIn == 'CUui0Jj4yheRNeltSqnisl7peyZ2'){
                                              return ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),onPressed: (){
                                                resSelection.selectedResidence =
                                                _residences[index];
                                                Navigator.of(context)
                                                    .pushNamed('/ResidenceUpdate');
                                              }, child: Text("Редактировать"));
                                          }
                                            return Container();
                                        }
                                    ),
                                  ],
                                );
                              }),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            Positioned(
                bottom: 0, left: 0, right: 0, child: ResidenceBottomBar()),
          ],
        ),
      ),
    );
  }
}
