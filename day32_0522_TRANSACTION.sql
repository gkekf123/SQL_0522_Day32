----- Ʈ�����(���� �۾�����) -----
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;
DELETE FROM depts WHERE department_id = 10;
SAVEPOINT delete10; -- ���̺�����Ʈ ���
DELETE FROM depts WHERE department_id = 20;
SAVEPOINT delete20; -- ���̺�����Ʈ ���
ROLLBACK TO delete20; -- 20�� ���̺�����Ʈ�� �ѹ�
ROLLBACK TO delete10; -- 20�� ���̺�����Ʈ�� �ѹ�
SELECT * FROM depts;
INSERT INTO depts VALUES(300, 'DEMO', NULL, 1000);
c