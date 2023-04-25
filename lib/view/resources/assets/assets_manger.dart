const String _baseFolder = 'assets/images';
const String _materialImagesBaseFolder = '$_baseFolder/material_content';
const String _lessonImagesBaseFolder = '$_baseFolder/lessons_content';

class SplashImageManger {
  static const splashImage = '$_baseFolder/splash_image/splash_image.png';
}

class MaterialImagesManger {
  static const advices = '$_materialImagesBaseFolder/advices/advices.png';
  static const exams = '$_materialImagesBaseFolder/exams/exams.png';
  static const lessons = '$_materialImagesBaseFolder/lessons/lessons.png';
  static const notes = '$_materialImagesBaseFolder/notes/notes.png';
  static const books = '$_materialImagesBaseFolder/books/books.png';
}

class LessonImagesManger {
  static const exercises = '$_lessonImagesBaseFolder/exercises/exercises.png';
  static const quiz = '$_lessonImagesBaseFolder/quiz/quiz.png';
  static const summaries = '$_lessonImagesBaseFolder/summaries/summaries.png';
  static const video = '$_lessonImagesBaseFolder/video/video.png';
  //- assets/images/lessons_content/question.png
  static const exercisesQuestion = '$_lessonImagesBaseFolder/question.png';
}

class ImageManger {
  static const notificationImageCenterRing =
      'assets/notification_images/center_ring.svg';
  static const notificationImageSmallRing =
      'assets/notification_images/bell_filled.svg';
}
