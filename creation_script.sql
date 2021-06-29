CREATE TYPE sex_type AS ENUM ('male', 'female', 'custom');
CREATE TYPE affected_type AS ENUM ('left', 'right', 'both');
CREATE TYPE exercise_type AS ENUM ('passive', 'active');  -- TODO: game type
CREATE TYPE reason_type AS ENUM ('end', 'spasms', 'tired', 'pain', 'unstated');
CREATE TYPE graph_type AS ENUM ('involvement_biceps', 'involvement_triceps');

CREATE TABLE Patient (
    id SERIAL PRIMARY KEY,
    password VARCHAR(255) NOT NULL CHECK(password != ''),
    first_name VARCHAR(30) NOT NULL CHECK(first_name != ''),
    last_name VARCHAR(30) NOT NULL CHECK(last_name != ''),
    email VARCHAR(50) UNIQUE NOT NULL CHECK(email != ''),
    phone_num VARCHAR(20) NOT NULL CHECK(phone_num != ''),
    sex sex_type NOT NULL,
    birth_date DATE NOT NULL,
    update_date TIMESTAMP NOT NULL DEFAULT now(),  --меняется при выполнении тренировки
    affected_side affected_type, -- заполняет доктор при запросе на связь
    angle_limit_from SMALLINT CHECK (angle_limit_from >= 0 and angle_limit_from <= angle_limit_to), -- заполняет доктор при запросе на связь
    angle_limit_to SMALLINT CHECK (angle_limit_from <= 135 and angle_limit_to >= angle_limit_from), -- заполняет доктор при запросе на связь
    is_verified BOOLEAN NOT NULL DEFAULT 'f'
);

CREATE TABLE Therapist (
    id SERIAL PRIMARY KEY,
    password VARCHAR(255) NOT NULL CHECK(password!=''),
    first_name VARCHAR(30) NOT NULL CHECK(first_name != ''),
    last_name VARCHAR(30) NOT NULL CHECK(last_name != ''),
    email VARCHAR(50) UNIQUE NOT NULL CHECK(email != ''),
    phone_num VARCHAR(20) NOT NULL CHECK(phone_num != ''),
    update_date TIMESTAMP NOT NULL DEFAULT now(),
    is_verified BOOLEAN NOT NULL DEFAULT 'f'-- нужна для поддветждения аккаунта по почте
);

CREATE TABLE Patient_of_therapist (
    id SERIAL PRIMARY KEY,
    therapist_id INTEGER REFERENCES Therapist(id) ON DELETE SET NULL,
    patient_id INTEGER REFERENCES Patient(id) ON DELETE CASCADE,
    therapy_start_date TIMESTAMP NOT NULL DEFAULT now(),
    therapy_end_date TIMESTAMP,

    CONSTRAINT duplicate_inserts_protection UNIQUE (therapist_id, patient_id, therapy_start_date)
);

CREATE TABLE Training (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES Patient(id) ON DELETE CASCADE,
    assigned_by VARCHAR(60) NOT NULL CHECK (assigned_by != ''),
    training_description TEXT,
    training_date DATE NOT NULL,
    exercises_amount INTEGER NOT NULL,
    training_duration TIME NOT NULL,  -- примерно если exercise_done_count == Null
    execution_date DATE,
    exercise_done_count INTEGER,
    stop_reason reason_type,
    spasms_total INTEGER
);

CREATE TABLE Exercise (
    id SERIAL PRIMARY KEY,
    training_id INTEGER REFERENCES Training(id) ON DELETE CASCADE,
    order_in_training INTEGER NOT NULL,
    type exercise_type NOT NULL,
    speed SMALLINT NOT NULL CHECK (speed > 0 and speed <=10),
    angle_limit_from SMALLINT NOT NULL,
    angle_limit_to SMALLINT NOT NULL,
    repetitions INTEGER NOT NULL CHECK (repetitions>0 and repetitions<=50),
    spasms_stop_value INTEGER NOT NULL DEFAULT '0' CHECK (spasms_stop_value<=10 and spasms_stop_value>=0),
    involvement_threshold SMALLINT CHECK (involvement_threshold > 0 and involvement_threshold <= 10),
    repetition_timeout TIME,
    duration TIME NOT NULL,
    spasms_count INTEGER
);

CREATE TABLE Exercise_graph (
    id SERIAL PRIMARY KEY,
    exercise_id INTEGER REFERENCES Exercise(id) ON DELETE CASCADE,
    graph_type graph_type NOT NULL,
    plot_x VARCHAR(30) [] NOT NULL,
    plot_y VARCHAR(30) [] NOT NULL
);





