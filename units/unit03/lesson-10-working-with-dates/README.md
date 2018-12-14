## Introduction to working with dates

## Date

A specific point in time, independent of any calendar or time zone.

**Overview**  
A Date value encapsulate a single point in time, independent of any particular calendrical system or time zone. Date values represent a time interval relative to an absolute reference date.

The Date structure provides methods for comparing dates, calculating the time interval between two dates, and creating a new date from a time interval relative to another date. Use date values in conjunction with DateFormatter instances to create localized representations of dates and times and with Calendar instances to perform calendar arithmetic.

## TimeInterval 

A number of seconds.

**Overview**  
A TimeInterval value is always specified in seconds; it yields sub-millisecond precision over a range of 10,000 years.

On its own, a time interval does not specify a unique point in time, or even a span between specific times. Combining a time interval with one or more known reference points yields a Date or DateInterval value.

**timeIntervalSince1970**  
The interval between the date value and 00:00:00 UTC on 1 January 1970.


## DateFormatter 

A formatter that converts between dates and their textual representations.

**Overview**  
Instances of DateFormatter create string representations of NSDate objects, and convert textual representations of dates and times into NSDate objects. For user-visible representations of dates and times, DateFormatter provides a variety of localized presets and configuration options. For fixed format representations of dates and times, you can specify a custom format string.

When working with date representations in ISO 8601 format, use ISO8601DateFormatter instead.

To represent an interval between two NSDate objects, use DateIntervalFormatter instead.

To represent a quantity of time specified by an NSDateComponents object, use DateComponentsFormatter instead.

## ISO8601DateFormatter 

A formatter that converts between dates and their ISO 8601 string representations.

**Overview**  
The ISO8601DateFormatter class generates and parses string representations of dates following the [ISO 8601](http://www.iso.org/iso/home/standards/iso8601) standard. Use this class to create ISO 8601 representations of dates and create dates from text strings in ISO 8601 format.


## Demo Playground 

```swift 
// Working with dates

// Making a Date from a TimeInterval
let timeIntervalInMilliseconds: TimeInterval = 1545262200000 // in milliseconds
let timeIntervalInSeconds = timeIntervalInMilliseconds / 1000 // seconds

/*
 why its always 1st jan 1970 , Because - '1st January 1970' usually called as "epoch date" is the date
 when the time started for Unix computers, and that timestamp is marked as '0'.
 Any time since that date is calculated based on the number of seconds elapsed
*/
let date1 = Date(timeIntervalSince1970: timeIntervalInSeconds ) // epoch

// Use DateFormatter to format Date to a String
// https://nsdateformatter.com/
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
let createdDateString = dateFormatter.string(from: date1)
print("date is \(createdDateString)")


// Making a Date from a String
let dateString1 = "2016-12-08"
dateFormatter.dateFormat = "yyyy-MM-dd"
if let date2 = dateFormatter.date(from: dateString1) {
  dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
  let dateString2 = dateFormatter.string(from: date2)
  print("dateString2 is \(dateString2)")
}


// Making a timestamp from the current Date() using IS08601DateFormatter()
let isoDateFormatter = ISO8601DateFormatter()
isoDateFormatter.formatOptions = [.withInternetDateTime,
                                  .withDashSeparatorInDate,
                                  .withFullDate,
                                  .withColonSeparatorInTimeZone]
isoDateFormatter.timeZone = TimeZone.current
let timestamp = isoDateFormatter.string(from: Date())
print(timestamp) // 2018-12-14T06:31:18-05:00


// Convert ISO timestamp String to a formatted Date
let timestampString = "2018-12-14T06:31:18-05:00"
if let date = isoDateFormatter.date(from: timestampString) {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "MMMM, dd, yyyy h:mm a"
  let dateFormattedString = dateFormatter.string(from: date)
  print(dateFormattedString) // December, 14, 2018 6:31 AM
} else {
  print("not a valid date")
}
```
