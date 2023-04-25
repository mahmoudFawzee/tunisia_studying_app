List<String> educationStagesDropItems = const [
  'مرحلة التعليم الاساسي',
  'مرحلة التعليم الثانوي',
];
List<String> yearsOfEducationDropItems = const [
  'السنة السابعة',
  'السنة الثامنة',
  'السنة التاسعة',
  'السنة الاولي',
  'السنة الثانية',
  'السنة الثالثة',
  'الباكلوريا',
];
//*done
List<String> secondSecondaryEducationDeptDropItems = const [
  'آداب',
  'علوم تجريبية',
  'اقتصاد و  خدمات',
  'اعلامية',
];
//TODO change the names of branches after adding them to the firebase
List<String> thirdSecondaryEducationDeptDropItems = const [
  'علوم تجريبية',
  'رياضيات',
  'اداب ',
  'علوم الاعلامية',
  'علوم تقنية',
  'اقتصاد و خدمات',
];
//TODO change the names of branches after adding them to the firebase
List<String> bacaloriaEducationDeptDropItems = const [
  'رياضيات',
  'علوم تجريبية',
  'علوم تقنية',
  'اداب',
  'اقتصاد و خدمات',
  'علوم الاعلامية',
  'رياضة'
];
List<String> allStudyingYearsAndBranches = [
  ...yearsOfEducationDropItems,
  ...secondSecondaryEducationDeptDropItems,
  ...thirdSecondaryEducationDeptDropItems,
];
List<String> subscriptionTypeList = const [
  'شهري',
  'سنوي',
];

const List<String> homeworkList = [
  "الفرض الثلاثي الأول",
  "الفرض الثلاثي الثاني",
  "الفرض الثلاثي الثالث",
];

List<String> homeWorkSectionsList = const [
  "الفروض التأليفية",
  "فروض المراقبة",
];
