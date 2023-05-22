--���� 1.
--DEPTS���̺��� ������ �߰��ϼ���
--DEPARTMENT_ID DEPARTMENT_NAME MANAGER_ID LOCATION_ID
--280���� null 1800
--290ȸ��� null 1800
--300���� 301 1800
--310�λ� 302 1800
--320���� 303 1700
SELECT * FROM depts;
INSERT INTO depts VALUES(280, '����', null, 1800);
INSERT INTO depts VALUES(290, 'ȸ���', null, 1800);
INSERT INTO depts VALUES(300, '����', null, 1800);
INSERT INTO depts VALUES(310, '�λ�', null, 1800);
INSERT INTO depts VALUES(320, '����', null, 1700);

COMMIT;

--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
UPDATE depts
SET department_name = 'IT bank'
WHERE department_name = 'IT Support';

commit;

--2. department_id�� 290�� �������� manager_id�� 301�� ����
SELECT * FROM depts;
UPDATE depts
SET manager_id = '301'
WHERE department_id = '290';

commit;

--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵� 1800���� �����ϼ���
UPDATE depts
SET department_name = 'IT Help',
    manager_id = 303,
    location_id = 1800
WHERE department_name = 'IT Helpdesk';

SELECT * FROM depts;
commit;

--4. ����, �λ�, ������ �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
SELECT * FROM depts;
UPDATE depts
SET manager_id = 301
WHERE department_name IN('����', '�λ�', '����');

commit;

--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
select * FROM depts;
DELETE FROM depts
WHERE department_id = 320;

DELETE FORM depts
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = '����');
--2. �μ��� NOC�� �����ϼ���
DELETE FROM depts
WHERE department_id = 220;

DELETE FORM depts
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'NOC');

COMMIT;

--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
DELETE FROM depts WHERE department_id > 200;
SELECT * FROM depts;

COMMIT;
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
SELECT * FROM depts;
UPDATE depts
SET manager_id = 100
WHERE manager_id IS NOT NULL
;

COMMIT;
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
SELECT * FROM DEPARTMENTS;
SELECT * FROM depts;

MERGE INTO depts d1
USING(SELECT * FROM departments)d2
ON(d1.department_id = d2.department_id)
WHEN MATCHED THEN
    UPDATE SET
        d1.department_name = d2.department_name,
        d1.manager_id = d2.manager_id,
        d1.location_id = d2.location_id
WHEN NOT MATCHED THEN
    INSERT VALUES (d2.department_id,
                   d2.department_name,
                   d2.manager_id,
                   d2.location_id)
;

commit;
--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE jobs_it AS(SELECT * FROM jobs WHERE MIN_SALARY > 6000);

commit;
--2. jobs_it ���̺� ���� �����͸� �߰��ϼ���
--JOB_ID JOB_TITLE MIN_SALARY MAX_SALARY
--IT_DEV ����Ƽ������ 6000 20000
--NET_DEV ��Ʈ��ũ������ 5000 20000
--SEC_DEV ���Ȱ����� 6000 19000
SELECT * FROM jobs_it;
INSERT INTO jobs_it VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO jobs_it VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO jobs_it VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);

COMMIT;
--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���
SELECT * FROM jobs;
MERGE INTO jobs_it j1
USING(SELECT * FROM jobs WHERE MIN_SALARY > 0) j2
ON(j1.job_id = j2.job_id)
WHEN MATCHED THEN
    UPDATE SET
        j1.min_salary = j2.min_salary,
        j1.max_salary = j2.max_salary
WHEN NOT MATCHED THEN
    INSERT VALUES(j2.job_id,
                  j2.job_title,
                  j2.min_salary,
                  j2.max_salary)
;
SELECT * FROM jobs_it;
COMMIT;