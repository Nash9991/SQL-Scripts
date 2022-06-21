/*
The script above will give you all the databases you have in your instance with their IO Read and IO Write stall.
A column (io_stall) contains the addition of the read IO and write IO.
You can further order the result of this script in such a way that you can know which file has maximum read and write IO.

Once you know the file which has maximum IO stall, you can do either of the following to improve the performance of the query.  Do not forget to subscribe SQL in Sixty Seconds series.

Reduce workload on the database file
Improve overall performance of queries on that database file
Replace with a faster disk for better IOPS
*/

SELECT
	DB_NAME(mf.database_id) AS [Database Name],
	mf.physical_name [Physical Name],
	num_of_reads,
	num_of_bytes_read,
	io_stall_read_ms,
	num_of_writes,
	num_of_bytes_written,
	io_stall_write_ms,
	io_stall,
	size_on_disk_bytes
FROM
	sys.dm_io_virtual_file_stats(null,null) AS vfs
INNER JOIN sys.master_files AS mf ON mf.database_id = vfs.database_id AND mf.file_id = vfs.file_id
ORDER BY
	io_stall DESC