--
-- MULTI_MX_REPARTITION_W1_UDT
--

\c - - - :worker_1_port
SET client_min_messages = LOG;
-- Query that should result in a repartition join on UDT column.
SET citus.task_executor_type = 'task-tracker';
SET citus.log_multi_join_order = true;

-- This query was intended to test "Query that should result in a repartition
-- join on int column, and be empty." In order to remove broadcast logic, we
-- manually make the query router plannable.
SELECT * FROM repartition_udt JOIN repartition_udt_other
    ON repartition_udt.pk = repartition_udt_other.pk
	WHERE repartition_udt.pk = 1;

SELECT * FROM repartition_udt JOIN repartition_udt_other
    ON repartition_udt.udtcol = repartition_udt_other.udtcol
	WHERE repartition_udt.pk > 1
	ORDER BY repartition_udt.pk;
