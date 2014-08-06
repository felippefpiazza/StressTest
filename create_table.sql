create table responses (test_name varchar(255), 
						min integer ,
						sec decimal(6,4) , 
						tot decimal(7,4) ,
						created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
						

create table requests (test_name varchar(255), 
						created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

