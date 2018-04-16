Create Database IWork2;
go
create function Application_Status 
(@applicant varchar(50) , @a_id int)
returns BIT
begin
Declare @returnedValue BIT;
declare @a_status varchar(50);
select @a_status = a.applicant_status from Applications a where a.applicant = @applicant AND a.a_id = @a_id;
if(@a_status = 'Accepted') 
SET @returnedValue = '1';
else 
SET @returnedValue = '0';

RETURN @returnedValue;
end

--