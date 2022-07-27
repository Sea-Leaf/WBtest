import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/LoginService.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    bool userLoggedIn = loginService.isUserLoggedIn();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Панель Управления"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () async{
                        if (userLoggedIn){
                          await loginService.signOut();
                          Navigator.of(context).pushNamed('/Welcomepage');
                        }
                        else{
                          bool success = await loginService.signInWithGoogle();
                          if(loginService.loggedInUserModel?.uid != 'CUui0Jj4yheRNeltSqnisl7peyZ2'){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Вы не администратор вход запрещен")));
                            await loginService.signOut();
                          }
                          if (success){
                            Navigator.of(context).pushNamed('/ResidencePage');
                          }
                      }
                    },
                    child: Container(
                      width: 215,
                      child: Row(
                        children: [
                          Icon(userLoggedIn ? Icons.logout : Icons.login,
                              color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text(userLoggedIn ? 'Выйти из аккаунта' : 'Войти в аккаунт',
                              style: TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                    )),
                ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () async{
                      if (loginService.loggedInUserModel?.uid == 'CUui0Jj4yheRNeltSqnisl7peyZ2'){
                        Navigator.of(context).pushNamed('/ResidenceCntrPage');
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Вы не администратор вход запрещен")));
                        await loginService.signOut();
                      }
                    },
                    child: Text("Добавить резиденцию",
                            style: TextStyle(fontSize: 20, color: Colors.white))
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
