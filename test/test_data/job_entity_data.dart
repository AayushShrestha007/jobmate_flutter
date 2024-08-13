
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';

class JobTestData {
  JobTestData._();

  static List<JobEntity> getJobTestData() {
    return [
      const JobEntity(
        id: '1',
        title: 'Software Engineer',
        workType: 'Full-Time',
        description: 'Develop and maintain software applications.',
        skills: 'Dart, Flutter',
        qualification: 'BSc in Computer Science',
      ),
      const JobEntity(
        id: '2',
        title: 'Data Scientist',
        workType: 'Contract',
        description: 'Analyze and interpret complex data sets.',
        skills: 'Dart, Flutter',
        qualification: 'MSc in Data Science',
      ),
      // Add more job entities as needed
    ];
  }
}
