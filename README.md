# KeepInTouch
KeepInTouch™ is a personalised and fun project that helps to literally "keep in touch" with contacts throughout the year - during birthdays, holidays as well as regular monthly intervals.

This Readme provides a brief overview of the backend database created using Microsoft SQL Server. Please refer to annotations and comments within the codes for details.



## The problem

I like to greet my contacts on the following occasions:
* Individual anniversaries (e.g., birthdays, graduation days, etc.)
* Yearly events (e.g., Christmas, New Year’s Eve, etc.)
* Monthly reminders based on frequency (e.g. say hello to a family member every month)

Additionally, I classify my contacts into relationships, based on which I determine how often to keep in touch with a person (e.g. keep in touch with a family member every month). Exceptions are allowed (e.g. a specific family member with whom I like to maintain contact twice a year instead of every month).

In addition to storing the infomation, I like to setup reminders on Google Calender.

Hence, the requirements are as follows:
1. Set up a normalized database to store the relevant information efficiently
2. Create CSV exports for Google Calendar
3. Create CSV exports to play around with the data in Python or other tools



## Tables

![KeepInTouch](https://drive.google.com/uc?export=view&id=1tQatRgzKNerotFsOH-fYkjazRmWtjaOf)

Description of the tables are summarised as follows:

1. PERSONS - `tb_Person`:
This is a central table to store names of every individual. All other tables are to be connected to it.

2. FREQUENCIES - `tb_Relation`, `tb_Frequency`, `tb_PersonFrequency`:
These tables store information on relationships and how often to keep in touch with each person.

3. ANNIVERSARIES - `tb_Anniversary`, `tb_PersonAnniversary`:
These tables store information on anniversaries (e.g., birthdays, graduation days, etc.)

4. EVENTS - `tb_Event`, `tb_PersonEvent`, `tb_Year`, `tb_YearEvent`:
These tables store information on yearly events (e.g., Christmas, New Year’s, etc.) The tb_YearEvent table provides the option to store events whose dates change every year (e.g. exact date of Eid al-Fitr changes every year as it is based on the lunar calendar.)

5. MONTHS - `tb_Month`, `tb_PersonMonth`:
These tables as basically "overview tables" that compile information on “events” and “anniversaries” from no. 3 and 4. Moreover, based on frequencies in no. 2, periodic reminders can be set by entering an "M" (e.g. keep in touch with John every 4 months, i.e. 3 times a year ⇒ in addition to his birthday and Christmas greeting, another month needs to be allocated.)

6. TIMELINE - `tb_Timeline`:
This table is a transposed form of tb_Month in no. 5. This is an extra “fun part” of this project that helps to finalize the data, i.e. all 3 aspects - events, anniversaries and monthly reminders. Ideally, this should be done using a front-end application.



## Functions

A number of functions have been created for use in views, procedures, triggers as well as CSV exports.

* Scalar-valued functions:
  * `sf_CalculateAge`: based on birthday, calculate the age this year (to be used in a procedure)
  * `sf_GetFirstSunday`: determine the date of the first Sunday of the month (to be used in a procedure)

* Table-valued functions:
  * `tf_AnniversariesString`: prepare anniversaries as string (to be used in a procedure)
  * `tf_EventsThisYear`: compile annual events of this year
  * `tf_Persons`: compile all persons including relationships
  * `tf_Anniversaries`, `tf_Events`, `tf_Frequencies`, `tf_Months`: compile respective information by joining with multiple tables as well as tf_Persons to display information in a logical manner



## Procedures

Procedures are named according to the tables on which they focus on. They are as follows:

* Add new records to tables:
  * `sp_CurrentYearADD`: add current year if not in system
  * `sp_PersonEventADD`: add CROSS JOIN of tb_Person and tb_Event
  * `sp_PersonMonthADD`: add CROSS JOIN of tb_Person and tb_Month
  * `sp_YearEventADD`: add CROSS JOIN of tb_Year and tb_Event

* Reset tables:
  * `sp_PersonAnniversaryRESET`: delete all data
  * `sp_PersonEventRESET`: set “selection” to FALSE (not delete!)
  * `sp_PersonFrequencyRESET`: delete all data
  * `sp_PersonMonthRESET`: delete all data
  * `sp_YearEventRESET`: delete all data

* Update tables:
  * `sp_PersonMonthUPDATE`: update tb_PersonMonth based on changes in Anniversaries and Events

* Procedures that run to ensure data consistency:
  * `sp_PersonMonthAutosetM`: when frequency is monthly, then automatically set “M” (reduces manual work)
  * `sp_PersonMonthCleanMSlash`: cleaning up updated information
  * `sp_PersonMonthRESETM`: delete all monthly reminders i.e. “M” from tb_PersonMonth
  * `sp_YearEventUPDATE`: update only current year events, based on edits in tb_Event

* Prepare exports for Google Calendar:
  * `sp_Z_Export_Google1`: anniversaries (these are all day events)
  * `sp_Z_Export_Google2`: events and monthly reminders (these take place from 1pm to 2pm)

* Timeline - the extra “fun part”:
  * `sp_PersonmonthTOTimeline`: transpose the data, and update tb_Timeline
  * `sp_TimelineTOPersonmonth`: transpose the transposed data i.e. tb_Timeline, and update tb_Month



## Triggers

Triggers automatically execute many of the above mentioned procedures. They are as follows:
* `tb_Anniversary`: DELETE
* `tb_Event`: INSERT, UPDATE
* `tb_Frequency`: DELETE
* `tb_Month`: INSERT, DELETE
* `tb_Person`: INSERT, DELETE
* `tb_PersonAnniversary`: INSERT, UPDATE
* `tb_PersonEvent`: UPDATE
* `tb_PersonMonth`: UPDATE
* `tb_Relation`: DELETE
* `tb_Year`: INSERT



## Views

Views are based on the table functions created earlier:
* Anniversaries:
  * `vw_Anniversary_All`
  * `vw_Anniversary_Isnull`
  * `vw_Anniversary_Notnull`
* Events: 
  * `vw_Event_All`
  * `vw_Event_NotSelected`
  * `vw_Event_Selected`
* Events this year:
  * `vw_EventsThisYear_All`
  * `vw_EventsThisYear_Incomplete`
* Frequencies:
  * `vw_Frequency_All`
  * `vw_Frequency_Edited`
  * `vw_Frequency_NotEdited`
* Months:
  * `vw_Month_All`
  * `vw_Month_Empty`
  * `vw_Month_Filled`
* Timeline (extra fun part):
  * `vw_Month_Tr`
  * `vw_Month_Tr_COMPLETE`
  * `vw_Month_Tr_INCOMPLETE`
* Views used for compiling other views, yet usable:
  * `vw_Month_Tr_Description`
  * `vw_Month_Tr_Summary`
  * `vw_Person_All`



## CSV exports

After inserting all the data and making the necessary selections, CSV exports can made ([here is a tutorial](https://solutioncenter.apexsql.com/how-to-export-sql-server-data-to-a-csv-file/)).

* Exports for Google Calendar:
  * Execute the procedures `sp_Z_Export_Google1` and `sp_Z_Export_Google2`
  * Export the tables `tb_Z_Export_Google1` and `tb_Z_Export_Google2`

* Exports to play around with the data in Python or other tools:
  * Export the views `vw_Frequency_All`, `vw_Anniversary_All`, `vw_Event_All` and `vw_Month_All`



## Questions/suggestions?

Please feel free to share your feedback. Thank you very much for your collaboration! 🤜🤛
