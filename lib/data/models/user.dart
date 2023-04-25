
class MyUser {
  final String gender;
  final String name;
  final String educationalStage;
  final String studyingYear;
  final String? branch;
  final String phoneNumber;
  
  final String email;
  final String password;
  
  const MyUser({
    required this.gender,
    required this.name,
    required this.educationalStage,
    required this.studyingYear,
    required this.branch,
    required this.phoneNumber,
    
    required this.email,
    required this.password,
    
  });
  get userName {
    return name;
  }

  get userStudyingYear {
    return studyingYear;
  }

  get userGender {
    return gender;
  }

  

  Map<String, Object?> toFirestoreObj() {
    return {
      'gender': gender,
      'name': name,
      'educationalStage': educationalStage,
      'studyingYear': studyingYear,
      'branch': branch,
      'phoneNumber': phoneNumber,
      
      'email': email,
      
    };
  }

  factory MyUser.fromFirebase(
      Map<String, dynamic> firebaseUser) {
    String gender = firebaseUser['gender'];
    String name = firebaseUser['name'];
    String educationalStage = firebaseUser['educationalStage'];
    String studyingYear = firebaseUser['studyingYear'];
    String? branch = firebaseUser['branch'];
    String phoneNumber = firebaseUser['phoneNumber'];
    String email = firebaseUser['email'];
    
    
    return MyUser(
        gender: gender,
        name: name,
        educationalStage: educationalStage,
        studyingYear: studyingYear,
        branch: branch,
        phoneNumber: phoneNumber,
        
        email: email,
        password: '',
        );
  }
}
