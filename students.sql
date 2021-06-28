create database students_progress;


-------------------------------------------------- Create tables -------------------------------------------------------
create table group_of_students(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    name TEXT NOT NULL ,
    year_of_admission DATE NOT NULL ,
    institute TEXT NOT NULL
);

create table progress(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    current_progress DECIMAL,
    semester_progress DECIMAL,
    group_of_students_id BIGINT references group_of_students(id) ON DELETE SET NULL
);

create table students(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    full_name TEXT NOT NULL ,
    group_of_students_id BIGINT references group_of_students(id) ON DELETE SET NULL ,
    year_of_birth DATE NOT NULL ,
    progress_id BIGINT references progress(id) ,
    year_of_admission DATE NOT NULL
);

create table attendance(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    current_attendance INT NOT NULL ,
    student_id BIGINT references students(id) ON DELETE SET NULL,
    semester_attendance INT NOT NULL ,
    overall_attendance INT NOT NULL
);

------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------- Insert Values ------------------------------------------------------

-- group of students --
INSERT INTO public.group_of_students (id, name, year_of_admission, institute)
                                VALUES (DEFAULT, 'БСБО-02-19', '2019-09-01', 'КБСП');
INSERT INTO public.group_of_students (id, name, year_of_admission, institute)
                                VALUES (DEFAULT, 'БСБО-03-19', '2019-09-01', 'КБСП');
INSERT INTO public.group_of_students (id, name, year_of_admission, institute)
                                VALUES (DEFAULT, 'БСБО-01-19', '2019-09-01', 'КБСП');
INSERT INTO public.group_of_students (id, name, year_of_admission, institute)
                                VALUES (DEFAULT, 'ИНБО-01-20', '2020-09-01', 'ИТ');
INSERT INTO public.group_of_students (id, name, year_of_admission, institute)
                                VALUES (DEFAULT, 'УПБО-02-18', '2018-09-01', 'ИТУ');

-- progress --
INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
                                VALUES (DEFAULT, 4.78, 4.56, 1);
INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
                                VALUES (DEFAULT, 3, 3, 2);
INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
                                VALUES (DEFAULT, 5, 5, 3);
INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
                                VALUES (DEFAULT, 2.2, 3.5, 4);
INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
                                VALUES (DEFAULT, 4.1, 3.8, 5);
INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
                                VALUES (DEFAULT, 3.3, 3.8, 1);

-- students --
INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Шагиджанян Андре Альбертович', 1, '2001-07-09', 1, '2019-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Самоев Алигаджи Иванович ', 2, '1996-09-26', 2, '2019-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Хасанов Хасан Хасанович', 3, '2010-10-12', 3, '2018-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Петров Петр Петрович', 4, '2001-07-03', 4, '2020-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Наталья Евсеева', 5, '2000-08-01', 5, '2018-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Андреев Дмитрий Игоревич', 1, '2001-06-19', 6, '2019-09-01');

-- attendance --
INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 10, 1, 53, 342);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 5, 2, 12, 123);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 8, 3, 23, 234);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 21, 4, 65, 485);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 30, 5, 80, 800);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 2, 6, 3, 21);

------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------ Queries ---------------------------------------------------------

-- 2.1 вывод всех людей с заменой id на название группы и условием в академе или нет --
SELECT s.full_name,
CASE WHEN gos.name IS NULL THEN 'уход в академический год' ELSE gos.name END
FROM students as s
LEFT JOIN group_of_students gos on s.group_of_students_id = gos.id;

-- 2.2 view с важной информацией о студенте --
CREATE VIEW students_info AS
SELECT s.full_name, s.year_of_birth,
       CASE WHEN gos.name IS NULL THEN 'уход в академический год' ELSE gos.name END,
       a.semester_attendance, p.semester_progress
FROM students as s
LEFT JOIN group_of_students gos on s.group_of_students_id = gos.id
LEFT JOIN attendance a on s.id = a.student_id
LEFT JOIN progress p on s.progress_id = p.id;

SELECT * FROM students_info;

-- 2.3 выбрать студентов у которых семестровый прогресс больше текущего c выводом названия группы и института --
SELECT info.full_name, info.year_of_birth, info.group, info.institute,
       (SELECT p.semester_progress FROM progress AS p WHERE info.id = p.id)
FROM (SELECT s.id, s.full_name, s.year_of_birth, gos.name as "group", gos.institute
        FROM students AS s LEFT JOIN group_of_students gos ON s.group_of_students_id = gos.id) AS info
WHERE (SELECT p.semester_progress FROM progress AS p WHERE info.id = p.id) >
      (SELECT current_progress FROM progress AS p WHERE info.id = p.id);

-- 2.4 средняя успеваемость и средняя посещаемость среди групп --
SELECT gos.name, avg(p.current_progress) AS "AVERAGE PROGRESS"
FROM students AS s LEFT JOIN group_of_students AS gos ON s.group_of_students_id = gos.id
LEFT JOIN progress AS p ON s.progress_id = p.id
GROUP BY gos.name
HAVING avg(p.current_progress) > 2.5 AND gos.name IS NOT NULL;

-- 2.5 вывод студентов из групп бсбо --
SELECT s.full_name, s.year_of_birth, gos.name
FROM students AS s LEFT JOIN group_of_students gos on s.group_of_students_id = gos.id
WHERE gos.name = ANY (SELECT name FROM group_of_students WHERE name LIKE 'БСБО%');

------------------------------------------------------------------------------------------------------------------------


------------------------------------------------ Create Indexes --------------------------------------------------------

CREATE INDEX "group" ON students(group_of_students_id);

CREATE INDEX "progress" ON students(progress_id);

------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------- Triggers ---------------------------------------------------------

CREATE TRIGGER InsertProgress AFTER INSERT ON progress FOR EACH ROW EXECUTE PROCEDURE set_progress_to_zero();

CREATE TRIGGER UpdateProgress AFTER UPDATE ON progress FOR EACH ROW WHEN
    (pg_trigger_depth() = 0) EXECUTE PROCEDURE set_progress_to_zero();

CREATE TRIGGER DeleteProgress AFTER DELETE on students FOR EACH ROW EXECUTE PROCEDURE delete_on_progress();

CREATE OR REPLACE FUNCTION set_progress_to_zero() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE progress SET semester_progress = CASE WHEN semester_progress IS NULL OR semester_progress < 0 THEN 0
        WHEN semester_progress > 5 THEN 5
        ELSE semester_progress END;
    UPDATE progress SET current_progress = CASE WHEN current_progress IS NULL THEN semester_progress
        WHEN current_progress < 0 THEN 0
        WHEN current_progress > 5 THEN 5
        ELSE current_progress END;
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION delete_on_progress() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM progress WHERE progress.id = OLD.progress_id;
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql';

------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------- CRUD Operations ----------------------------------------------------

CREATE PROCEDURE insert_group(g_name varchar, g_year date, g_institute varchar)
LANGUAGE SQL
AS $$
    INSERT INTO group_of_students (id, name, year_of_admission, institute)
    VALUES (DEFAULT, g_name, g_year, g_institute);
$$;

CREATE PROCEDURE insert_progress(p_cur_prog decimal, p_sem_prog decimal, p_g_id bigint)
    LANGUAGE SQL
AS $$
    INSERT INTO progress (id, current_progress, semester_progress, group_of_students_id)
    VALUES (DEFAULT, p_cur_prog, p_sem_prog, p_g_id);
$$;

CREATE PROCEDURE insert_student(s_full_name varchar, s_group bigint, s_birth date, s_progress bigint, s_admission date)
    LANGUAGE SQL
AS $$
    INSERT INTO students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
    VALUES (DEFAULT, s_full_name, s_group, s_birth, s_progress, s_admission);
$$;

CREATE PROCEDURE insert_attendance(a_cur_at int, a_student bigint, a_sem_at int, a_over_at int)
    LANGUAGE SQL
AS $$
INSERT INTO attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, a_cur_at, a_student, a_sem_at, a_over_at);
$$;

CREATE PROCEDURE update_group(g_id bigint, g_name varchar, g_year date, g_institute varchar)
    LANGUAGE SQL
AS $$
    UPDATE group_of_students
    SET name = g_name, year_of_admission = g_year, institute = g_institute WHERE id = g_id;
$$;

CREATE PROCEDURE update_progress(g_id bigint, p_cur_prog decimal, p_sem_prog decimal, p_g_id bigint)
    LANGUAGE SQL
AS $$
    UPDATE progress
    SET current_progress = p_cur_prog, semester_progress = p_sem_prog, group_of_students_id = p_g_id WHERE id = g_id;
$$;

CREATE PROCEDURE update_student(g_id bigint, s_full_name varchar, s_group bigint,
                                            s_birth date, s_progress bigint, s_admission date)
    LANGUAGE SQL
AS $$
    UPDATE students
    SET full_name = s_full_name, group_of_students_id = s_group, year_of_birth = s_birth
                        , progress_id = s_progress, year_of_admission = s_admission WHERE id = g_id;
$$;

CREATE PROCEDURE update_attendance(g_id bigint, a_cur_at int, a_student bigint, a_sem_at int, a_over_at int)
    LANGUAGE SQL
AS $$
    UPDATE attendance
    SET current_attendance = a_cur_at, semester_attendance = a_sem_at,
        student_id = a_student, overall_attendance = a_over_at WHERE id = g_id;
$$;

CREATE PROCEDURE delete_group(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM group_of_students WHERE id = g_id;
$$;

CREATE PROCEDURE delete_progress(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM progress WHERE id = g_id;
$$;

CREATE PROCEDURE delete_student(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM students WHERE id = g_id;
$$;

CREATE PROCEDURE delete_attendance(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM attendance WHERE id = g_id;
$$;

------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------- Transaction ---------------------------------------------------------

CREATE OR REPLACE PROCEDURE add_student (student_full_name text, group_id bigint, birth date, admit_year date,
            current_prog decimal, semester_prog decimal, current_attend int, semester_attend int, overall_attend int) AS
$$
BEGIN
    INSERT INTO progress (id, current_progress, semester_progress, group_of_students_id)
    VALUES (DEFAULT, current_prog, semester_prog, group_id);
    IF student_full_name = ANY(SELECT full_name FROM students) AND birth = ANY(SELECT year_of_birth FROM students) THEN
        RAISE NOTICE 'This student exists on database';
        ROLLBACK;
    ELSE
        INSERT INTO students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
        VALUES (DEFAULT, student_full_name, group_id, birth, currval(pg_get_serial_sequence('progress', 'id')), admit_year);
        INSERT INTO attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
        VALUES (DEFAULT, current_attend, currval(pg_get_serial_sequence('students', 'id')), semester_attend, overall_attend);
        COMMIT;
    END IF;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------ Cursor ----------------------------------------------------------

-- прибавить в семестровой успеваемости у студентов у которых хорошая успеваемость --
CREATE OR REPLACE PROCEDURE give_bonus_to_student () AS
$$
DECLARE
    class CURSOR FOR SELECT current_attendance, semester_attendance, student_id FROM attendance;
BEGIN
    FOR cls IN class LOOP
        IF cls.current_attendance > 20 THEN
            UPDATE progress
            SET current_progress = current_progress + 0.5
            WHERE id=cls.student_id;
        ELSEIF cls.semester_attendance > 60 THEN
            UPDATE progress
            SET semester_progress = semester_progress + 0.5
            WHERE id=cls.student_id;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------- Scalar function -----------------------------------------------------

-- во вьюшке из пункта 2 дополнительной колонкой будет разница между текущей и семестровой успеваемостью --
CREATE OR REPLACE FUNCTION get_progress_difference(s_id bigint) RETURNS decimal AS
$$
DECLARE
    diff decimal;
BEGIN
    SELECT current_progress - semester_progress FROM progress
        LEFT JOIN students ON progress.id = students.progress_id WHERE students.id=s_id INTO diff;
    RETURN diff;
END;
$$ LANGUAGE 'plpgsql';

-- сама вьюшка --
CREATE VIEW scalar_students_info AS
SELECT s.full_name AS "Full name", s.year_of_birth AS "Birth",
       CASE WHEN gos.name IS NULL THEN 'уход в академический год' ELSE gos.name END AS "Group",
       a.semester_attendance AS "Semester attendance", p.semester_progress AS "Semester progress",
       get_progress_difference(s.id)
FROM students as s
LEFT JOIN group_of_students gos on s.group_of_students_id = gos.id
LEFT JOIN attendance a on s.id = a.student_id
LEFT JOIN progress p on s.progress_id = p.id;

SELECT * FROM scalar_students_info;


CREATE OR REPLACE FUNCTION get_student_with_group(s_id bigint) RETURNS
    table(id bigint, full_name text, group_name text, group_id bigint) AS
$$
DECLARE
    curs CURSOR FOR SELECT s.id, s.full_name, gos.name, gos.id AS g_id FROM students s
        LEFT JOIN group_of_students gos ON s.group_of_students_id = gos.id WHERE s_id=s.id;
BEGIN
    FOR cur IN curs LOOP
        id = cur.id;
        full_name = cur.full_name;
        group_name = cur.name;
        group_id = cur.g_id;
        RETURN next;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';

------------------------------------------------------------------------------------------------------------------------
