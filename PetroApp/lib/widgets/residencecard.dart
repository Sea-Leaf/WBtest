import 'package:flutter/material.dart';
import '../models/residence.dart';
import '../services/StorageService.dart';


class ResidenceCard extends StatelessWidget {
  Residence? residence;
  Function? onCardClick;

  ResidenceCard({ this.residence, this.onCardClick });

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return GestureDetector(
      onTap: () {
        this.onCardClick!();
      },
      child: Container(
          margin: EdgeInsets.all(20),
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FutureBuilder(
                    future: storage.downloadURL(residence!.imgPath,residence!.Id),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                        return Container(
                          child: Image.network(snapshot.data!, fit: BoxFit.cover),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent
                            ]))),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(this.residence!.Name,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Buyan',
                            fontSize: 25),)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
