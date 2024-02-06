import 'dart:async';


import 'package:appwrite/appwrite.dart';
import 'package:partypilot/database.dart';
import 'package:partypilot/saved_data.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('656f8bf4a4af93975ce3')
    .setSelfSigned(status: true); 

    Account account = Account(client);
    Future<String>createUser(String name , String email,String Password)async{
      try{
        final user = await account.create(userId: ID.unique(), email: email, password: Password,name:name);
        saveUserData(name, email, user.$id);
        return "success";
      }
        
        on AppwriteException catch(e){
            return e.message.toString();
        }
      }
      // for login user

      Future loginUser(String email, String password) async{
        try{
          final user = await account.createEmailSession( email:email ,password: password);
           SavedData.saveUserId(user.userId);
    getUserData();
          return true;
        }
        on AppwriteException catch(e){
          return false ; 
        }
      }

      // for logout 
      Future logoutUser()async{
        await account.deleteSession(sessionId: 'current');
      }
      //check user have active session or not

      Future checkSession()async{
        try{
          await account.getSession(sessionId: 'current');
          return true;
        }
        catch (e){
          return false;
        }
      }