# Assignment Grading Policy

## Grading Policy in Swift
```swift
import UIKit

var fellowProjectSubmitted: Bool
var projectSubmissionDate: Date?
let projectDeadlineDate: Date
var fellowProjectGrade: Float
let maxProjectGrade: Float
var lateOrRevisionPenalty: Float = 5.0

switch fellowProjectSubmitted {
case true:
    if projectSubmissionDate! <= projectDeadlineDate {
        print("Assignments submitted on time will be graded within one (1) week.")
        if fellowProjectGrade <= maxProjectGrade / 2 {
            print("""
                Assignments submitted on time that receive an initial grade of 50% or less
                may be revised and resubmitted within one (1) week of initial grading
                for a maximum grade of \(maxProjectGrade - lateOrRevisionPenalty) points.
                """)
        } else {
            print("""
                Assignments submitted on time that receive an initial grade that is greater than 50%
                are not eligible for resubmission.
                """)
        }
    } else {
        print("""
            Assignments submitted late will be graded within one (1) week of \(projectSubmissionDate!)
            for a maximum grade of \(maxProjectGrade - lateOrRevisionPenalty) points.
            """)
    }
case false:
    print("If a fellow does not submit an assignment, they will receive a score of 0 points.")
}
```

## Grading Policy in English
* Assignments submitted on time will be graded within one (1) week of submission.
  * Assignments submitted on time that receive an initial grade of 50% or less of the maximum score may be revised and resubmitted within one (1) week of initial grading for a maximum grade of 5 points less than the maximum score.
  * Assignments submitted on time that receive an initial grade that is greater than 50% of the maximum score are not eligible for resubmission.
* Assignments submitted late will be graded within one (1) week of submission for a maximum grade of 5 points less than the maximum score.
* If a fellow does not submit an assignment, they will receive a score of 0 points.

## Notes
- Grading policy is subject to change and fellows will be notified of changes.
- For any questions regarding this grading policy, please ask the iOS instructional team (Alex, Alan, Kaniz, Jermaine, Maggie) via email using their firstName[at]pursuit[dot]org or on Slack.
