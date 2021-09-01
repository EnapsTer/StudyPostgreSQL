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
    group_of_students_id BIGINT references group_of_students(id) ON DELETE SET NULL,
    difference_from_group DECIMAL
);

create table students(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    full_name TEXT NOT NULL ,
    group_of_students_id BIGINT references group_of_students(id) ON DELETE SET NULL ,
    year_of_birth DATE NOT NULL ,
    progress_id BIGINT references progress(id) ON DELETE CASCADE,
    year_of_admission DATE NOT NULL
);

create table attendance(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    current_attendance INT NOT NULL ,
    student_id BIGINT references students(id) ON DELETE CASCADE,
    semester_attendance INT NOT NULL ,
    overall_attendance INT NOT NULL
);

DROP TABLE group_of_students, students, attendance, progress CASCADE;

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

INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
VALUES (DEFAULT, 2.9, 2.5, 1);

INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
VALUES (DEFAULT, 4.32, 4.43, 3);

INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
VALUES (DEFAULT, 2.3, 2.1, 2);

INSERT INTO public.progress (id, current_progress, semester_progress, group_of_students_id)
VALUES (DEFAULT, 3.45, 3.34, 3);


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
VALUES (DEFAULT, 'Никтов Никто Никтоевич', NULL, '2000-08-01', 5, '2018-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Андреев Дмитрий Игоревич', 1, '2001-06-19', 6, '2019-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Ванеев Игорь Ктотович', 1, '2001-06-19', 7, '2019-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Орлов Сергей Иванович', 3, '2000-08-04', 8, '2019-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Амарян Гурам Нерзадович', 2, '1991-02-12', 9, '2019-09-01');

INSERT INTO public.students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
VALUES (DEFAULT, 'Чебатков Евгений Андреевич', 3, '1990-02-12', 10, '2019-09-01');

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

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 43, 7, 45, 234);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 52, 8, 82, 302);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 42, 9, 32, 198);

INSERT INTO public.attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, 56, 10, 25, 152);

------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------ Queries ---------------------------------------------------------

-- 2.1 вывод всех людей с заменой id на название группы и условием в академе или нет --
SELECT s.full_name,
CASE WHEN gos.name IS NULL THEN 'уход в академический год' ELSE gos.name END
FROM students as s
LEFT JOIN group_of_students gos on s.group_of_students_id = gos.id;

-- TODO клиент - критерий упорядоченности задает пользователь при выполнении
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

-- 2.4 средняя успеваемость среди групп --
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

CREATE INDEX "group_index" ON students(group_of_students_id);

CREATE INDEX "progress_index" ON students(progress_id);

------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------- Triggers ---------------------------------------------------------

CREATE TRIGGER InsertProgress AFTER INSERT ON progress FOR EACH ROW EXECUTE PROCEDURE set_difference_group_progress();

CREATE TRIGGER UpdateProgress AFTER UPDATE ON progress FOR EACH ROW WHEN
    (pg_trigger_depth() = 0) EXECUTE PROCEDURE set_difference_group_progress();

CREATE TRIGGER DeleteProgress AFTER DELETE on progress FOR EACH ROW EXECUTE PROCEDURE set_difference_group_progress();

--- Установить значение отставание от группы ---
CREATE OR REPLACE FUNCTION set_difference_group_progress() RETURNS TRIGGER AS
$$
DECLARE
    class CURSOR FOR
        SELECT gos.id, avg(p.current_progress) AS average_progress
        FROM progress AS p LEFT JOIN group_of_students AS gos on p.group_of_students_id = gos.id
        WHERE gos.name IS NOT NULL
        GROUP BY gos.id;
BEGIN
    FOR cls IN class LOOP
        UPDATE progress SET difference_from_group = current_progress - cls.average_progress
        WHERE group_of_students_id = cls.id;
    END LOOP;
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

CALL insert_group('БИСО-05-21', '2021-09-01', 'ИТ'); -- todo delete


CREATE PROCEDURE insert_progress(p_cur_prog decimal, p_sem_prog decimal, p_g_id bigint)
    LANGUAGE SQL
AS $$
    INSERT INTO progress (id, current_progress, semester_progress, group_of_students_id)
    VALUES (DEFAULT, p_cur_prog, p_sem_prog, p_g_id);
$$;

CALL insert_progress(3.1, 3.4, 6); -- todo delete

CREATE PROCEDURE insert_student(s_full_name varchar, s_group bigint, s_birth date, s_progress bigint, s_admission date)
    LANGUAGE SQL
AS $$
    INSERT INTO students (id, full_name, group_of_students_id, year_of_birth, progress_id, year_of_admission)
    VALUES (DEFAULT, s_full_name, s_group, s_birth, s_progress, s_admission);
$$;

CALL insert_student('Челов Чел Челович', 6, '2001-04-12', 11, '2021-09-01'); -- todo delete

CREATE PROCEDURE insert_attendance(a_cur_at int, a_student bigint, a_sem_at int, a_over_at int)
    LANGUAGE SQL
AS $$
INSERT INTO attendance (id, current_attendance, student_id, semester_attendance, overall_attendance)
VALUES (DEFAULT, a_cur_at, a_student, a_sem_at, a_over_at);
$$;

CALL insert_attendance(52, 11, 53, 213); -- todo delete

CREATE PROCEDURE update_group(g_id bigint, g_name varchar, g_year date, g_institute varchar)
    LANGUAGE SQL
AS $$
    UPDATE group_of_students
    SET name = g_name, year_of_admission = g_year, institute = g_institute WHERE id = g_id;
$$;

CALL update_group(6, 'БССО-02-21', '2021-09-01', 'ET'); -- todo delete

CREATE PROCEDURE update_progress(g_id bigint, p_cur_prog decimal, p_sem_prog decimal, p_g_id bigint)
    LANGUAGE SQL
AS $$
    UPDATE progress
    SET current_progress = p_cur_prog, semester_progress = p_sem_prog, group_of_students_id = p_g_id WHERE id = g_id;
$$;

CALL update_progress(11, 4.1, 4.4, 6); -- todo delete

CREATE PROCEDURE update_student(g_id bigint, s_full_name varchar, s_group bigint,
                                            s_birth date, s_progress bigint, s_admission date)
    LANGUAGE SQL
AS $$
    UPDATE students
    SET full_name = s_full_name, group_of_students_id = s_group, year_of_birth = s_birth
                        , progress_id = s_progress, year_of_admission = s_admission WHERE id = g_id;
$$;

CALL update_student(11,'Челов Чел Челович', 6, '2000-06-12', 11, '2021-09-01'); -- todo delete

CREATE PROCEDURE update_attendance(g_id bigint, a_cur_at int, a_student bigint, a_sem_at int, a_over_at int)
    LANGUAGE SQL
AS $$
    UPDATE attendance
    SET current_attendance = a_cur_at, semester_attendance = a_sem_at,
        student_id = a_student, overall_attendance = a_over_at WHERE id = g_id;
$$;

CALL update_attendance(11,5, 11, 3, 13); -- todo delete

CREATE PROCEDURE delete_group(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM group_of_students WHERE id = g_id;
$$;

CALL delete_group(6); -- todo delete

CREATE PROCEDURE delete_progress(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM progress WHERE id = g_id;
$$;

CALL delete_progress(11);

CREATE PROCEDURE delete_student(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM students WHERE id = g_id;
$$;

CALL delete_student(11);

CREATE PROCEDURE delete_attendance(g_id bigint)
    LANGUAGE SQL
AS $$
    DELETE FROM attendance WHERE id = g_id;
$$;

CALL delete_attendance(11);

------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------- Transaction ---------------------------------------------------------

CREATE OR REPLACE PROCEDURE add_student (student_full_name text, group_id bigint, birth date, admit_year date,
            current_prog decimal, semester_prog decimal, current_attend int, semester_attend int, overall_attend int) AS
$$
BEGIN
    INSERT INTO progress (id, current_progress, semester_progress, group_of_students_id)
    VALUES (DEFAULT, current_prog, semester_prog, group_id);
    IF student_full_name = ANY(SELECT full_name FROM students) AND birth = ANY(SELECT year_of_birth FROM students)
           AND admit_year = ANY(SELECT year_of_admission FROM students)
           AND group_id = ANY (SELECT group_of_students_id from students)
    THEN
        ROLLBACK;
        RAISE EXCEPTION 'This student exists on database';
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
    attend CURSOR FOR SELECT current_attendance, semester_attendance, student_id FROM attendance;
BEGIN
    FOR cls IN attend LOOP
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

CALL give_bonus_to_student();

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
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM get_student_with_group(9);

------------------------------------------------------------------------------------------------------------------------
