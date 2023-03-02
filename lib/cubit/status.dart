abstract class AppStatus{}
class InitialState extends AppStatus{}
class LoginSucceeded extends AppStatus{}
class RegisterSucceeded extends AppStatus{}
class CreateUserSucceeded extends AppStatus{}
class CreateUserFailed extends AppStatus{
  String?error;
  CreateUserFailed(this.error);

}
class getAllUsers extends AppStatus{}
class createPosts extends AppStatus{}
class uploadImagePosts extends AppStatus{}
class uploadFilesCoverAndUpdates extends AppStatus{}
class getALLPosts extends AppStatus{}
class uploadFilesProfileAndUpdates extends AppStatus{}
class ChangeIndex extends AppStatus{}
class getImagePosts extends AppStatus{}
class getIMageMessages extends AppStatus{}
class CountOfDocumont extends AppStatus{}
class ChangeValueOfIndex extends AppStatus{}
class updateDataSucceeded extends AppStatus{}
class GetUserDataSucceeded extends AppStatus{}
class RegisterFailed extends AppStatus{
  dynamic?error;
  RegisterFailed(this.error);
}
class uploadImageMessages extends AppStatus{}
class LoginFailed extends AppStatus{
  String? error;
  LoginFailed(this.error);
}
class UseImagePickerCover extends AppStatus{}
class UseImagePickerProfile extends AppStatus{}
class uploadFilesCovers extends AppStatus{}
class uploadFilesProfiles extends AppStatus{}
class getMessage extends AppStatus{}
class send1 extends AppStatus{}
class send2 extends AppStatus{}