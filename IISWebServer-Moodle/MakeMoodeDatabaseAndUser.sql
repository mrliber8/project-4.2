create database moodle default character set utf8;
grant all privileges on moodle.* to 'moodleuser'@'localhost' identified by 'yourpassword';
flush privileges;
quit