SET SERVEROUTPUT ON;
CONNECT system/system;

DROP USER ExoEntr CASCADE;
DROP USER adminExoEntr CASCADE;
DROP USER gestionnaireVenteExoEntr CASCADE;
DROP ROLE adminRole;
DROP ROLE gestionnaireVenteRole;

CREATE USER ExoEntr IDENTIFIED BY ExoEntr;
GRANT DBA TO ExoEntr WITH ADMIN OPTION;
-- connection de ExoEntr
CONNECT ExoEntr/ExoEntr;

-- @types.sql;


@sequences.sql;
@tables.sql;
@triggers.sql;
@procs.sql;
@roles.sql;
@fillSchema.sql;
@query.sql;

SET SERVEROUTPUT OFF;
DISCONNECT