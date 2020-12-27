--²é¿´OracleËø±íÓï¾ä
select l.session_id sid,
       s.serial#,
       l.locked_mode,
       l.oracle_username,
       l.os_user_name,
       s.machine,
       s.terminal,
       o.object_name,
       s.logon_time,
       p.spid
  from v$locked_object l, all_objects o, v$session s, v$process p
 where l.object_id = o.object_id
   and l.session_id = s.sid
   and s.paddr = p.addr
 order by sid, s.serial#;