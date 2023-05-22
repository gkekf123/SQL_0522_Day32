----- DDL�� CREATE, ALTER, DROP
-- ����Ŭ ��ǥ ������ Ÿ��(VARCHAR2 - ��������, CHAR - ��������, NUMBER - ����, DATE - ��¥)
-- CREATE
CREATE TABLE DEPT2(
    DEPT_NO NUMBER(2), --  �ڸ���
    DEPT_NAME VARCHAR(20), -- �ִ� 20����Ʈ, ��������
    DEPT_YN CHAR(1), -- 1Byte ����������
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10, 3) -- 10�ڸ�, ������ 3
);
  
SELECT * FROM dept2;

INSERT INTO dept2 VALUES(99, 'SALES', 'Y', SYSDATE, 3.14);
-- INSERT INTO dept2 VALUES(98, 'SALES', 'ȫ', SYSDATE, 3.14); -- ����� �����ʾ� ����

COMMIT;

---------------------------------------------------------------------------------------------

-- ALTER
-- �� �߰�
ALTER TABLE dept2 ADD(DEPT_COUNT NUMBER(3));

-- �� �̸� ����
ALTER TABLE dept2 RENAME COLUMN DEPT_COUNT TO EMP_COUNT;

-- �� ����(Ÿ�Ժ���)
ALTER TABLE dept2 MODIFY(EMP_COUNT NUMBER(10));

-- �� ����
ALTER TABLE dept2 DROP COLUMN emp_count;

SELECT * FROM dept2;

---------------------------------------------------------------------------------------------

-- DROP
DROP TABLE dept2;
-- �������� FK�� ����, ���̺� ����
DROP TABLE dept2 CASCASE �������Ǹ�;

---------------------------------------------------------------------------------------------

-- TRUNCATE
TRUNCATE TABLE dept2;