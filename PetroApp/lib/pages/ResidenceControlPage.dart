import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:petroapp/models/architect.dart';
import 'package:petroapp/models/objects.dart';
import 'package:petroapp/services/FireBaseService.dart';
import 'package:petroapp/services/StorageService.dart';

import '../models/residence.dart';

class ResidenceCntrPage extends StatefulWidget {
  ResidenceCntrPage({Key? key}) : super(key: key);
  @override
  State<ResidenceCntrPage> createState() => _ResidenceCntrPageState();
}

class _ResidenceCntrPageState extends State<ResidenceCntrPage> {
  List<Objct> objct = [];
  List<Architect> architect = [];
  List<TextEditingController> _archcontrollerID = [];
  List<TextEditingController> _archcontrollerName = [];
  List<TextEditingController> _archcontrollerInfo = [];
  List<TextEditingController> _archcontrollerDate = [];
  List<TextEditingController> _objcontrollerID = [];
  List<TextEditingController> _objcontrollerName = [];
  List<TextEditingController> _objcontrollerDesc = [];
  List<TextEditingController> _objcontrollerType = [];
  List<TextEditingController> _objcontrollerDate = [];
  var array = [];
  var array2 = [];
  var index = 0;
  var index2 = 0;
  final _formKey = GlobalKey<FormBuilderState>();
  final ResIDController = TextEditingController();
  final ResDateController = TextEditingController();
  final ResStyleController = TextEditingController();
  final ResNameController = TextEditingController();
  final ResDescController = TextEditingController();
  final ResPathController = TextEditingController();
  final ResYController = TextEditingController();
  final ResXController = TextEditingController();
  @override
  void dispose() {
    ResIDController.dispose();
    ResDateController.dispose();
    ResStyleController.dispose();
    ResNameController.dispose();
    ResDescController.dispose();
    ResPathController.dispose();
    ResYController.dispose();
    ResXController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Storage storage = Storage();
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Добавление"),
            actions: [IconButton(
                onPressed: () {
                  for ( index  ; index < array.length ; index++){
                    architect.add(Architect(
                        Id: _archcontrollerID[index].text,
                        Name: _archcontrollerName[index].text,
                        Info: _archcontrollerInfo[index].text,
                        Birth: Timestamp.fromDate(DateTime.parse(_archcontrollerDate[index].text))));
                    setState(() {
                      architect.length;
                    });
                  };

                  for ( index2  ; index2 < array2.length ; index2++){
                    objct.add(Objct(
                        Id: _objcontrollerID[index2].text,
                        Name: _objcontrollerName[index2].text,
                        Type:  _objcontrollerType[index2].text,
                        Info: _objcontrollerDesc[index2].text,
                        CreateDate: Timestamp.fromDate(DateTime.parse(_objcontrollerDate[index2].text))));
                    setState(() {
                      objct.length;
                    });
                  };

                  Residence residence = Residence(
                      Id: ResIDController.text,
                      BuildDate: Timestamp.fromDate(
                          DateTime.parse(ResDateController.text)),
                      Style: ResStyleController.text,
                      Name: ResNameController.text,
                      Info: ResDescController.text,
                      imgPath: ResPathController.text,
                      Arch: architect,
                      Obj: objct,
                      Location: GeoPoint(double.parse(ResXController.text),
                          double.parse(ResYController.text)));
                  FireBaseServices().AddResidence(residence);
                  Navigator.of(context).pushNamed('/ResidencePage');
                },
                icon: Icon(Icons.save)),
            ],
          ),
            body: FormBuilder(
      key: _formKey,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.5, color: Colors.black),
                    ),
                  ),
                  child: Text('Данные резеденции',
                      style: TextStyle(fontSize: 16, fontFamily: 'Buyan'),
                  textAlign: TextAlign.center,),
                ),
                FormBuilderTextField(
                  name: "ID",
                  controller: ResIDController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                        (val) {
                          String number = val ?? '';
                      if (number == null)
                        return 'Поле не может быть пустым';
                      return null;
                    }
                  ]),
                  decoration: InputDecoration(labelText: "ID резиденции",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2)
                  ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 5),
                FormBuilderTextField(
                  name: "BuildDate",
                  controller: ResDateController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                        (val) {
                          String number = val ?? '';
                      if (number == null)
                        return 'Поле не может быть пустым';
                      return null;
                    }
                  ]),
                  decoration:
                      InputDecoration(labelText: "Дата создания резиденции",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2)
                        ),),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 5),
                FormBuilderTextField(
                  name: "Name",
                  controller: ResNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                        (val) {
                          String number = val ?? '';
                      if (number == null)
                        return 'Поле не может быть пустым';
                      return null;
                    }
                  ]),
                  decoration: InputDecoration(labelText: "Название резиденции",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                    ),),
                ),
                SizedBox(height: 5),
                FormBuilderTextField(
                  name: "Style",
                  controller: ResStyleController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                        (val) {
                          String number = val ?? '';
                      if (number == null)
                        return 'Поле не может быть пустым';
                      return null;
                    }
                  ]),
                  decoration: InputDecoration(labelText: "Архитектурный стиль",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                    ),),
                ),
                SizedBox(height: 5),
                FormBuilderTextField(
                  name: "Info",
                  minLines: 1,
                  maxLines: 40,
                  controller: ResDescController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                        (val) {
                          String number = val ?? '';
                      if (number == null)
                        return 'Поле не может быть пустым';
                      return null;
                    }
                  ]),
                  decoration: InputDecoration(labelText: "Описание резиденции",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                    ),),
                ),
                SizedBox(height: 5),
                FormBuilderTextField(
                  name: "imgPath",
                  controller: ResPathController,
                  enabled: false,
                  readOnly: true,
                  decoration:
                      InputDecoration(labelText: "Путь до картинки резиденции",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2)
                        ),),
                ),
                SizedBox(height: 5),
                FormBuilderTextField(
                  name: "LocationX",
                  controller: ResXController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                        (val) {
                          String number = val ?? '';
                      if (number == null)
                        return 'Поле не может быть пустым';
                      return null;
                    }
                  ]),
                  decoration:
                      InputDecoration(labelText: "Координаты X резиденции",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2)
                        ),),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 5),
                FormBuilderTextField(
                  name: "LocationY",
                  controller: ResYController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                        (val) {
                          String number = val ?? '';
                      if (number == null)
                        return 'Поле не может быть пустым';
                      return null;
                    }
                  ]),
                  decoration:
                      InputDecoration(labelText: "Координаты Y резиденции",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2)
                        ),),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.5, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('Архитекторы',
                        style: TextStyle(fontSize: 16, fontFamily: 'Buyan'),
                        textAlign: TextAlign.center,),
                      TextButton(onPressed: (){
                        //* architect.removeAt(int.parse(ArchIDController.text));
                        setState(() {
                          //*architect.length;
                          array.add(array.isNotEmpty ? array.last + 1 : 0);
                          _archcontrollerID.add(TextEditingController());
                          _archcontrollerName.add(TextEditingController());
                          _archcontrollerInfo.add(TextEditingController());
                          _archcontrollerDate.add(TextEditingController());
                          _archcontrollerID[array.last].text = array.last.toString();
                        });
                      }, child: Icon(Icons.add)),
                    ],
                  )
                ),
                Container(
                  child: Column(
                    children: [
                      ...array.map((e){
                        return  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                              border: Border(
                              top: BorderSide(width: 3, color: Colors.blueGrey),
                                bottom: BorderSide(width: 3, color: Colors.blueGrey),
                                left: BorderSide(width: 3, color: Colors.blueGrey),
                                  right: BorderSide(width: 3, color: Colors.blueGrey),
                              )),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Arch_Id",
                                enabled: false,
                                controller: _archcontrollerID[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration: InputDecoration(labelText: "ID Архитектора",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Arch_Name",
                                controller: _archcontrollerName[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration: InputDecoration(labelText: "Имя архитектора",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Arch_Info",
                                minLines: 1,
                                maxLines: 40,
                                controller: _archcontrollerInfo[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration: InputDecoration(
                                    labelText: "Информаци об архитекторе",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Arch_Bth",
                                controller: _archcontrollerDate[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration: InputDecoration(
                                    labelText: "Дата рождения архитектора",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                                keyboardType: TextInputType.number,
                              ),
                              TextButton(onPressed: (){
                                if(architect.isNotEmpty){
                                  architect.removeAt(int.parse(_archcontrollerID[e].text));
                                  setState(() {
                                    architect.length;
                                  });
                                }
                                setState(() {
                                  array.remove(e);
                                });
                              }, child: Icon(Icons.delete)),
                            ],
                          ),
                        );
                      }),

                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.5, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('Архитектурные объекты',
                        style: TextStyle(fontSize: 16, fontFamily: 'Buyan'),
                        textAlign: TextAlign.center,),
                      TextButton(onPressed: (){
                        //* architect.removeAt(int.parse(ArchIDController.text));
                        setState(() {
                          //*architect.length;
                          array2.add(array2.isNotEmpty ? array2.last + 1 : 0);
                          _objcontrollerID.add(TextEditingController());
                          _objcontrollerName.add(TextEditingController());
                          _objcontrollerType.add(TextEditingController());
                          _objcontrollerDesc.add(TextEditingController());
                          _objcontrollerDate.add(TextEditingController());
                          _objcontrollerID[array2.last].text = array2.last.toString();
                        });
                      }, child: Icon(Icons.add)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      ...array2.map((e) {
                        return  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border(
                                top: BorderSide(width: 3, color: Colors.blueGrey),
                                bottom: BorderSide(width: 3, color: Colors.blueGrey),
                                left: BorderSide(width: 3, color: Colors.blueGrey),
                                right: BorderSide(width: 3, color: Colors.blueGrey),
                              )),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Obj_Id",
                                controller: _objcontrollerID[e],
                                enabled: false,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration: InputDecoration(labelText: "ID объекта",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Obj_Name",
                                controller: _objcontrollerName[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration:
                                InputDecoration(labelText: "Название объекта",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Obj_Type",
                                controller: _objcontrollerType[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration: InputDecoration(labelText: "Тип объекта",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Obj_Info",
                                minLines: 1,
                                maxLines: 40,
                                controller: _objcontrollerDesc[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration:
                                InputDecoration(labelText: "Описание объекта",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                name: "Obj_CreatDate",
                                controller: _objcontrollerDate[e],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                      (val) {
                                        String number = val ?? '';
                                    if (number == null)
                                      return 'Поле не может быть пустым';
                                    return null;
                                  }
                                ]),
                                decoration:
                                InputDecoration(labelText: "Дата постройки объекта",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2)
                                  ),),
                                keyboardType: TextInputType.number,
                              ),
                              TextButton(onPressed: (){
                                if(objct.isNotEmpty){
                                  objct.removeAt(int.parse(_objcontrollerID[e].text));
                                  setState(() {
                                    objct.length;
                                  });
                                }
                                setState(() {
                                  array2.remove(e);
                                });
                              }, child: Icon(Icons.delete)),
                            ],
                          ),
                        );
                      }),
                    ]),
                ),
                ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),onPressed:() async{
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg'],
                  );
                  if (results == null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Файл не выбран")
                    )
                    );
                    return null;
                  }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;
                  storage.UploadFile(path,fileName, ResIDController.text).then((value) => print('Готово'));
                  setState(() {
                    ResPathController.text = fileName;
                  });
                }, child: Text("Загрузить фото"))
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
