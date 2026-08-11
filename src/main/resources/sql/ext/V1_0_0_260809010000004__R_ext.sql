-- 多余dict数据
delete from dict where id in (1002,1004,1006,1007,1008,1009,1011,1013);

alter table sys_id_generator RENAME TO id_generator;