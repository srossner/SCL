close all
clear
clc


UsersData = [];
for i=1:5
   a = randi(100,1);
   b = randi(100,1);
   LocalData = [a;b];
   UsersData = [UsersData LocalData];
end
UsersData;


TestTable = SpecificTable('LeftMode');
for i=1:6
    TestTable.addTable( UsersData );
end
TestTable.changeMode();
TestTable.addTable( UsersData );

