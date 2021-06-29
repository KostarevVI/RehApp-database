SELECT * FROM therapist;


INSERT INTO patient(password,
    first_name,
    last_name,
    email,
    phone_num,
    sex ,
    birth_date ,
    affected_side , -- заполняет доктор при запросе на связь
    angle_limit_from , -- заполняет доктор при запросе на связь
    angle_limit_to , -- заполняет доктор при запросе на связь
    is_verified) VALUES
                        (123, 'Patrick', 'Star', 'patric123@yandex.ru', '+79522333041', 'male', now()::date, 'right', 15, 100, 't'),
                        (123, 'Jane', 'Doe', 'jane222a@yandex.ru', '+79522333041', 'female', now()::date, 'right', 15, 100, 't'),
                        (123, 'Roman', 'Kalashnikov', 'l321sd222a@yandex.ru', '+79532133041', 'male', now()::date, 'both', 0, 135, 't'),
                        (123, 'Vladislav', 'Kostarev', 'lad22vfda@yandex.ru', '+793210233041', 'male', now()::date, 'left', 10, 10, 't'),
                        (123, 'Anastasia', 'Petropavlovna', 'pit212a@yandex.ru', '+79321333041', 'female', now()::date, 'both', 10, 90, 't'),
                        (123, 'Lada', 'Calina', 'lad222a@yandex.ru', '+79500233041', 'male', now()::date, 'left', 10, 90, 'f'),
                        (123, 'Naruto', 'Uzumaki', 'naris231ld@ya.ru', '+79521233041', 'male', now()::date, 'left', 90, 100, 't');


SELECT * FROM patient;


INSERT INTO therapist(password,
    first_name,
    last_name,
    email,
    phone_num,
    is_verified) VALUES ('pbkdf2:sha256:150000$MrvwKZq5$1ab3cd3a2c12514cd46b68b70b4f90c9b12be14ac17a264b03d5a6153929fd9d', 'Vladislav', 'Kostarev', 'vladsonic23@yandex.ru', '+79500373069', 't'),
                        ('123', 'Therapist', 'Therapistov', 'therap@ya.ru', '+73213785182', 't'),
                        ('123', 'Maximilian', 'Novomarkovich', 'maxrap@ya.ru', '+73213785182', 't'),
                        ('123', 'John', 'Doe', 'johndoe@ya.ru', '+73213785182', 't'),
                        ('123', 'Emilia', 'Clark', 'emily123@ya.ru', '+72321378582', 't'),
                        ('123', 'Paul', 'Billson', 'epasd123@ya.ru', '+73211285182', 'f');

SELECT * FROM therapist;

INSERT INTO patient_of_therapist(therapist_id, patient_id)
VALUES (1, 1),
       (1, 2), (1, 3), (1, 4), (1, 5), (1, 7);


INSERT INTO training(patient_id ,
    assigned_by ,
    training_description ,
    training_date ,
    exercises_amount ,
    training_duration ,  -- примерно если exercise_done_count == Null
    execution_date ,
    exercise_done_count ,
    stop_reason ,
    spasms_total )
    VALUES (5, 'Vladislav K.', NULL, '2021-06-09', 2, '00:04:00', '2021-06-16', null, null, null),
           (1, 'Vladislav K.', NULL, '2021-06-17', 5, '00:07:32', '2021-06-17', 5, 'end', 0),
           (2, 'John D.', NULL, '2021-06-15', 7, '00:12:21', '2021-06-15', 7, 'end', 2),
           (1, 'Vladislav K.', NULL, '2021-06-16', 3, '00:07:00', '2021-06-23', null, null, null),
           (1, 'Vladislav K.', 'You can do it' , '2021-06-13', 4, '00:06:42', '2021-06-13', 0, 'spasms', 5),
           (1, 'Vladislav K.', NULL, '2021-06-11', 1, '00:00:00', '2021-06-11', 1, 'end', 2),
           (3, 'Maximilian N.', NULL, '2021-06-11', 3, '00:05:21', '2021-06-11', 3, 'end', 0),
           (4, 'Emilia C.', 'Hi!', '2021-06-13', 3, '00:02:01', '2021-06-13', 3, 'end', 0);


INSERT INTO training(patient_id ,
    assigned_by ,
    training_description ,
    training_date ,
    exercises_amount ,
    training_duration ,  -- примерно если exercise_done_count == Null
    execution_date ,
    exercise_done_count ,
    stop_reason ,
    spasms_total )
    VALUES (3, 'Vladislav K.', NULL, '2021-06-25', 2, '00:04:00', null, null, null, null),
           (1, 'Vladislav K.', NULL, '2021-06-25', 5, '00:07:32', null, null, null, null),
           (2, 'John D.', NULL, '2021-06-26', 7, '00:12:21', null, null, null, null),
           (2, 'John D.', NULL, '2021-06-20', 10, '00:52:21', null, null, null, null),
           (5, 'Vladislav K.', NULL, '2021-06-23', 2, '00:04:00', null, null, null, null),
           (1, 'Vladislav K.', NULL, '2021-06-20', 2, '00:04:00', null, null, null, null);


SELECT * FROM training;



