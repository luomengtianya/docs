## 常用命令

* 常用命令

  ```sql
   sqlplus /nolog   --登录
   conn /as sysdba  --以管理员的身份运行
   alter user system identified by Pan#1208;--修改system用户账号密码；
   alter user sys identified by Pan#1208;--修改sys用户账号密码；
   create user xingquan identified by Pan#1208; -- 创建内部管理员账号密码；
   grant connect,resource,dba to xingquan; --将dba权限授权给内部管理员账号和密码；
   ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED; --修改密码规则策略为密码永不过期；（会出现坑，后面讲解）
   alter system set processes=1000 scope=spfile; --修改数据库最大连接数据；
  ```

* 查询表空间

  ```sql
  -- 其中用户名需使用大写
  select default_tablespace from dba_users where username='用户名';
  ```

* 创建表空间

  ```sql
  create tablespace GSQ
  logging
  datafile '/home/data/gsq.dbf'
  size 50m
  autoextend on
  next 50m maxsize 30720m
  extent management local;
  ```

* 再次利用以前表空间的数据

  ```sql
  create tablespace GSQ datafile '/home/data/gsq.dbf';
  ```

* 删除表空间数据

  ```sql
  drop tablespace GSQ including contents and datafiles;
  ```

* 用户关联表空间

  ```sql
  alter user xingquan default tablespace GSQ;
  ```

* 创建文件路径

  !> 导入数据需要,没有设置会报文件夹不可用的错误

  ```sql
  create directory dpdata as '/home/data';
  ```

* 授权文件路径

  ```sql
  grant read,write on directory dpdata to xingquan;
  ```

* 导入文件

  ```shell
  -- 授权
  chown -R oracle:oinstall /home/data
  
  --导入 parallel 并行数量
  impdp xingquan/Pan#1208@127.0.0.1:1521/helowin directory=dpdata dumpfile=TESTC2_%U.DMP REMAP_SCHEMA=admin:xingquan REMAP_TABLESPACE=DEFAULT_TBS:GSQ TABLE_EXISTS_ACTION=REPLACE logfile=impdp20221030.log parallel=4
  ```

* 查询数据库实例名

  ```sql
  select instance from v$thread;
  ```

* 查看表空间

  ```sql
  select * from v$tablespace;
  ```

* 查看表空间详情

  ```sql
  select file_name,tablespace_name from dba_data_files;
  ```

* 查看用户默认表空间

  ```sql
  SELECT username,default_tablespace FROM dba_users;
  ```

* 查看表空间大小

  ```sql
  SELECT FILE_NAME AS 数据文件路径,TABLESPACE_NAME AS 表空间名称,AUTOEXTENSIBLE AS 自动扩展,STATUS AS 状态,MAXBYTES AS 可扩展最大值,USER_BYTES AS 已使用大小,INCREMENT_BY AS 自动扩展增量 FROM dba_data_files;
  
  ```

* 扩展表空间

  ```sql
  -- 1.扩展空间，将数据文件扩大至1000MB
  alter database datafile 'D:\DataBase\Test.DBF' resize 100m;
  
  -- 2.自动增长，表空间不足时增加200MB，最大扩展50MB
  alter database datafile 'D:\DataBase\Test.DBF' autoextend on next 200m maxsize 50m; 
  
  -- 3.扩展无限大空间
  alter database DATAFILE 'D:\DataBase\Test.DBF'  autoextend on maxsize unlimited;
  ```



