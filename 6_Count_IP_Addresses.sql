/*
Given a database of first and last IPv4 addresses, 
calculate the number of addresses between them (including the first one, excluding the last one).
Input
---------------------------------
|     Table    | Column | Type  |
|--------------+--------+-------|
| ip_addresses | id     | int   |
|              | first  | text  |
|              | last   | text  |
---------------------------------
Output
-------------------------
|   Column    |  Type   |
|-------------+---------|
| id          | int     |
| ips_between | bigint  |
-------------------------

All inputs will be valid IPv4 addresses in the form of strings. 
The last address will always be greater than the first one.

* With input "10.0.0.0", "10.0.0.50"  => return   50 
* With input "10.0.0.0", "10.0.1.0"   => return  256 
* With input "20.0.0.10", "20.0.1.0"  => return  246
*/

-- my
--SELECT * FROM ip_addresses;

CREATE FUNCTION get_ip_address_count(ip_first varchar, ip_last varchar)
RETURNS bigint

language plpgsql
as
$$
declare
   ip_count bigint;
begin
        SELECT 
        (CAST(SPLIT_PART(ip_last,'.',4) AS bigint) +
         CAST(SPLIT_PART(ip_last,'.',3) AS bigint) * 256 +
         CAST(SPLIT_PART(ip_last,'.',2) AS bigint) * 65536 +
         CAST(SPLIT_PART(ip_last,'.',1) AS bigint) * 16777216) -
         
        (CAST(SPLIT_PART(ip_first,'.',4) AS bigint) +
         CAST(SPLIT_PART(ip_first,'.',3) AS bigint) * 256 +
         CAST(SPLIT_PART(ip_first,'.',2) AS bigint) * 65536 +
         CAST(SPLIT_PART(ip_first,'.',1) AS bigint) * 16777216)
         INTO ip_count;
         
         RETURN ip_count;
end;
$$;

SELECT ip.id, get_ip_address_count(ip.first, ip.last) AS ips_between
FROM ip_addresses AS ip;

-- bp
SELECT id, last::inet - first::inet as ips_between
FROM ip_addresses;