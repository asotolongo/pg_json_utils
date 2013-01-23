-- Function: contains(json, character varying)

-- DROP FUNCTION contains(json, character varying);

CREATE OR REPLACE FUNCTION contains(doc json, substr character varying)
  RETURNS boolean AS
$BODY$
declare

begin
if (position('"'||$2||'":' in $1::character varying )>0) then
return true;
else
return false;
end if;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE;


-- Function: containsvalue(json, character varying)

-- DROP FUNCTION containsvalue(json, character varying);

CREATE OR REPLACE FUNCTION containsvalue(doc json, substr character varying)
  RETURNS boolean AS
$BODY$
declare

begin
if (position($2 in $1::character varying )>0) then
return true;
else
return false;
end if;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE;

-- Function: equals(json, json)

-- DROP FUNCTION equals(json, json);

CREATE OR REPLACE FUNCTION equals(doc1 json, doc2 json)
  RETURNS boolean AS
$BODY$
declare

begin
if ( $1::character varying=$2::character varying ) then
return true;
else
return false;
end if;

end;

$BODY$
  LANGUAGE plpgsql VOLATILE;


CREATE OR REPLACE FUNCTION jsonhash(doc1 json)
  RETURNS integer AS
$BODY$
declare
valor character varying ;
suma integer=0;
i integer=1;
begin
  valor=md5($1::character varying);

  i := length(valor);
  loop
    suma:=suma+ascii(substring(valor from i for 1));
    i:=i-1;
    if i=0 then
      exit;
    end if;
  end loop;


return suma* ascii(substring(valor from 1 for 1))*ascii(substring(valor from 2 for 1));


end;

$BODY$
  LANGUAGE plpgsql VOLATILE;


CREATE OPERATOR ? (
leftarg = json,
rightarg = character varying,
procedure = contains

);

CREATE OPERATOR @> (
leftarg = json,
rightarg = character varying,
procedure = containsvalue

);


CREATE OPERATOR = (
leftarg = json,
rightarg = json,
procedure = equals

);



CREATE OPERATOR CLASS json_equal_ops
DEFAULT FOR TYPE json USING hash AS
OPERATOR 1   = ,

FUNCTION 1 jsonhash(json);




--CREATE INDEX test_index_json ON prueba USING hash(campo json_equal_ops);

