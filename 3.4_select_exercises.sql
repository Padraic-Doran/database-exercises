use albums_db;

describe albums;

select name from `albums`where artist = "Pink Floyd";

describe albums;

select release_date from albums where `name` = "Sgt. Pepper\'s Lonely Hearts Club Band";

select genre from albums where `name` = "Nevermind";

select name from `albums`where release_date <= 1999 and release_date >=1990; 

select name
from `albums`
where sales < 20;

select name from `albums` where genre = 'Rock';