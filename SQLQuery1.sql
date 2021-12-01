USE PublishingHouse
go
--1. ¬ своей базе данных найдите все таблицы, которые не имеют кластеризованных индексов.
--ƒл€ каждой из них добавьте кластеризованный индекс или измените первичный ключ на кластеризованный.
--ALTER TABLE dbo.Table_2 DROP CONSTRAINT PK_Table_2
--go
--ALTER TABLE dbo.Table_2 ADD CONSTRAINT PK_Table_2 
--    PRIMARY KEY CLUSTERED (id)

--	ALTER TABLE dbo.Table_3 DROP CONSTRAINT PK_Table_3
--go
--ALTER TABLE dbo.Table_3 ADD CONSTRAINT PK_Table_3 
--    PRIMARY KEY CLUSTERED (id)

--	ALTER TABLE dbo.Table_4 DROP CONSTRAINT PK_Table_4
--go
--ALTER TABLE dbo.Table_4 ADD CONSTRAINT PK_Table_4
--    PRIMARY KEY CLUSTERED (id)

--2. Ќайдите медленно выполн€емые запросы. —оздайте некластеризованные индексы, дл€ повышени€ скорости выполнени€ этих запросов.
--CREATE NONCLUSTERED INDEX Ind1
--ON Table1(Name_,Price,Country);

--CREATE NONCLUSTERED INDEX Ind2
--ON Table3(Debt);

--CREATE NONCLUSTERED INDEX Ind3
--ON Table4(PercentsOfAmmount);

--3. ¬озьмите одно из представлений, созданных на предыдущем зан€тии (в качестве домашнего задани€), и превратите его в индексируемое.

--create view PREDD 
--with schemabinding
--AS
--SELECT a.FirstName,a.LastName
--FROM dbo.Authors a
--WHERE Upper(Substring(a.FirstName,1,1)) IN ('A','B')

--CREATE UNIQUE CLUSTERED INDEX
--    ix_work_111 ON PREDD (FirstName, LastName);

--SELECT * FROM PREDD

--4. Ќаписать запрос с поиском, который будет выводить названи€ магазинов, которые  содержат слово "книга". ¬месте с названием магазина необходимо вывести страну их расположени€.

--CREATE INDEX ShoName
--ON Shops(NameShop);
--CREATE INDEX ConName
--ON Country(NameCountry);

--SELECT sh.NameShop,c.NameCountry
--From Shops sh 
--inner join Country c on c.ID_Country=sh.ID_Country
--WHERE LOWER(sh.NameShop) LIKE '%книга%'


--5.¬ыполните поиск всех книг, в названи€х которых содержатс€ слова "Java", "Guide" или "Web".

--CREATE INDEX BNAM
--ON Books(NameBook);
--SELECT b.NameBook FROM Books b 
--WHERE b.NameBook LIKE '%Java%' OR b.NameBook LIKE '%Guide%' OR b.NameBook LIKE '%Web%'

--6. Ќапишите запрос, который в результате работы выведет книги, с указанием их авторов и тематик: "Computer Science", "Science Fiction", "Web Technologies".  
--CREATE INDEX TNAM
--ON Theme(NameTheme);
--SELECT t.NameTheme,b.NameBook,a.FirstName+' '+a.LastName as FullNameAuthors
--FROM Books b inner join Authors a on a.ID_Author=b.ID_Author
--inner join Theme t on t.ID_Theme=b.ID_Theme
--WHERE t.NameTheme='Computer Science' OR t.NameTheme='Science Fiction' OR t.NameTheme='Web Technologies';

--7. ¬ыведите все названи€ магазинов, которые продавали книги после 01/01/2010.
--”кажите также объем продаж книг, месторасположение магазина 
--”словие: в названи€х книг встречаютс€ следующие совпадени€: "Windows"и "NET" или "Java" и "guide".

--CREATE INDEX DatI
--ON Sales(DateOfSale);

--SELECT sh.NameShop, s.DateOfSale,s.Quantity,c.NameCountry From Shops sh inner join Country c on c.ID_Country=sh.ID_Country
--inner join Sales s on s.ID_Shop=sh.ID_Shop
--WHERE s.DateOfSale > '2010.01.01' 