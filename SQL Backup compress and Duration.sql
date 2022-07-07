select database_name, 
       case 
            when  backup_size = compressed_backup_size then 'Compressed'
            else 'Not compressed'
        end as Compression, 
		backup_start_date,
        backup_finish_date,
		[Duration(Mins)] = DATEDIFF(MINUTE, backup_start_date, backup_finish_date)
from msdb.dbo.backupset
--where database_name ='DatabaseName'
order by backup_start_date desc