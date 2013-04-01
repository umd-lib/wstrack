begin;
CREATE OR REPLACE FUNCTION dmp(IN start_time text, IN end_time text, IN file_name text) RETURNS void
AS $$
DECLARE STATEMENT text;
BEGIN 
STATEMENT := 'COPY (Select * from History where timestamp >= ''' || to_timestamp(start_time, 'yyyy-mm-dd hh24:mi:ss') || ''' and timestamp <= ''' || to_timestamp(end_time, 'yyyy-mm-dd hh24:mi:ss') || ''') TO ''' || file_name || '''  DELIMITER AS '','' CSV HEADER';
EXECUTE STATEMENT;
END;$$
LANGUAGE plpgsql VOLATILE SECURITY DEFINER
COST 100;
ALTER FUNCTION dmp(text, text, text) OWNER TO root;
commit;