set define '^'
set concat on
set concat .
set verify off

@../env.sql

-------------------------------------------------------------------------------------

PROMPT  =============================================================================
PROMPT  ==   CREATE WORKSPACE ^workspace
PROMPT  =============================================================================
PROMPT


PROMPT Change session to APEX_USER
ALTER SESSION SET CURRENT_SCHEMA = ^apex_user;

declare
  v_workspace_id number;
begin
  select to_char(workspace_id)
    into v_workspace_id
    from apex_workspaces
   where workspace = upper('^workspace');

  dbms_output.put_line('Workspace ^workspace allready installed!');
exception
  when no_data_found then
  -- workspace does not exist, so add it
    apex_instance_admin.add_workspace (p_workspace => '^workspace',
                                       p_primary_schema => upper('^app_schema'));

    commit;
end;
/