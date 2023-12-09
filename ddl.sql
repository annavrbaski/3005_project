create table trainer (
    trainerID serial primary key,
    name varchar(255) not null,
    contact_info varchar(255),
    schedule text
);

create table member (
    memberID serial primary key,
    name varchar(255) not null,
    contact_info varchar(255),
    health_metrics text,
    fitness_goals text,
    loyalty_pts int
);

create table pt_session (
    sessionID serial primary key,
    memberID int not null,
    trainerID int not null,
    date date not null,
    time time not null,
    progress_notes text,
    foreign key (memberID) references member(memberID),
    foreign key (trainerID) references trainer(trainerID)
);

create table billing (
    billID serial primary key,
    memberID int not null,
    amount decimal(10, 2) not null,
    date date not null,
    service_type varchar(255) not null,
    payment_method varchar(50), 
    foreign key (memberID) references member(memberID)
);

create table room (
    roomID serial primary key,
    type varchar(255) not null,
    maintenance_schedule text
);

create table group_fitness (
    classID serial primary key,
    description text not null
);

create table class_schedule (
    roomID int not null,
    classID int not null,
    date date not null, 
    time time not null,
    primary key (classID, roomID),
    foreign key (classID) references group_fitness(classID),
    foreign key (roomID) references room(roomID)
);

create table event (
    eventID serial primary key,
    description text not null
);

create table event_schedule (
    eventID int not null,
    roomID int not null,
    date date not null,
    time time not null,
    primary key (eventID, roomID),
    foreign key (eventID) references event(eventID),
    foreign key (roomID) references room(roomID)
);

create table class_registration (
    memberID int not null,
    classID int not null,
    registration_date date not null,
    loyalty_pts int,
    primary key (memberID, classID),
    foreign key (memberID) references member(memberID),
    foreign key (classID) references group_fitness(classID)
);

create table event_registration (
    memberID int not null,
    eventID int not null,
    registration_date date not null,
    loyalty_pts int,
    primary key (memberID, eventID),
    foreign key (memberID) references member(memberID),
    foreign key (eventID) references event(eventID)
);