-- add new member
insert into MEMBER (name, contact_info, health_metrics, fitness_goals)
values 
('John Doe', 'john.doe@gmail.com', 'Height: 180cm, Weight: 80kg', 'Run a marathon'),
('Karen Smith', 'karent.smith@gmail.com', 'Height: 150cm, Weight: 60kg', 'Improve flexibility');

-- add trainer
insert into TRAINER (name, contact_info, schedule)
values ('Jane Smith', 'jane.smith@gmail.com', 'Monday-Friday 9am-5pm');

-- create room
insert into ROOM (type, maintenance_schedule) 
values ('Yoga Studio', 'Every 6 months');

-- create group fitness
insert into GROUP_FITNESS (description) 
values ('Yoga Class');

-- update member's contact info
update MEMBER
set contact_info = 'john.d.update@gmail.com'
WHERE name = 'John Doe';

-- set fitness goal for member
update MEMBER
set fitness_goals = 'Complete a triathlon'
where name = 'John Doe';

-- list all members with sepcific fitness goal
select *
from MEMBER
where fitness_goals LIKE '%triathlon%';

-- sechedule new pt session
insert into PT_SESSION (memberID, trainerID, date, time)
values ((select memberID from MEMBER where name = 'John Doe'),
        (select trainerID from TRAINER where name = 'Jane Smith'),
        '2023-12-15', '10:00');

-- record progress notes after pt session
update PT_SESSION
set progress_notes = 'Improved running pace'
where sessionID = (select sessionID from PT_SESSION
                   join MEMBER on PT_SESSION.memberID = MEMBER.memberID
                   where MEMBER.name = 'John Doe' and date = '2023-12-15');

-- add to class to schedule
insert into CLASS_SCHEDULE (roomID, classID, date, time)
values (1,1,'2023-12-10', '08:00:00'); 

-- list all classes available in specific room
select GROUP_FITNESS.description, CLASS_SCHEDULE.date, CLASS_SCHEDULE.time
from CLASS_SCHEDULE
join GROUP_FITNESS on CLASS_SCHEDULE.classID = GROUP_FITNESS.classID
where CLASS_SCHEDULE.roomID = 1;

-- register member for a class
insert into CLASS_REGISTRATION (memberID, classID, registration_date, loyalty_pts)
values ((select memberID from MEMBER where name = 'Karen Smith'),
        (select classID from GROUP_FITNESS where description = 'Yoga Class'),
        CURRENT_DATE, 10);

-- list all members ina specific class
select MEMBER.name
from MEMBER
join CLASS_REGISTRATION on MEMBER.memberID = CLASS_REGISTRATION.memberID
join GROUP_FITNESS on CLASS_REGISTRATION.classID = GROUP_FITNESS.classID
where GROUP_FITNESS.description = 'Yoga Class';