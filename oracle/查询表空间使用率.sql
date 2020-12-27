select 
    upper(f.tablespace_name) "表空间名",
    d.total "表空间大小(M)",
    d.total - f.free "已使用空间(M)",
    to_char(round((d.total - f.free) / d.total * 100, 2), '990.99') || '%' "使用比",
    f.free "空闲空间",
    to_char(round(f.free / d.total * 100, 2), '990.99') || '%' "空闲率"
from
    (select 
            tablespace_name, 
            round(sum(bytes) / (1024 * 1024), 2) free, 
            round(max(bytes) / (1024 * 1024), 2) max  
    from 
            sys.dba_free_space 
    group by 
            tablespace_name) f, 
    (select 
            tablespace_name, 
            round(sum(bytes) / (1024 * 1024), 2) total 
    from 
            sys.dba_data_files 
    group by 
            tablespace_name) d
where
            f.tablespace_name = d.tablespace_name
    and     f.tablespace_name not in ('UNDOTBS1', 'UNDOTBS2', 'SYSTEM', 'SYSAUX', 'USERS')
order by 4 desc
      

