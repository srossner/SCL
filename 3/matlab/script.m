close all
clear
clc

% Create a dymmy data to fill tables
UsersData = [];
for i=1:5
   a = randi(100,1);
   b = randi(100,1);
   LocalData = [a;b];
   UsersData = [UsersData LocalData];
end
UsersData;


% The first spet is defining a Mode for a table.
% The should be at least one Mode in order to print a tabble
CoulmnsName = {'1/2' '1/4' '1/8' '1/16' '1/32'};
RowsName = {'Error', 'Error red.'};
FirstMode = TableMode( CoulmnsName, RowsName  );

% Create a table with a particular titel
TestTable = SpecificTable('Assigment 3');

% Add a Mode to the TestTable
TestTable.addMode( FirstMode );

% Add new tables
for i=1:7
    TestTable.addTable( UsersData, 'Title' );
end

% Define and add a new mode
CoulmnsName = {'explcit|Euler' 'Heun' ...
                            'implicit|Euler' 'Adams-|-Moulton' ...
                            'Adams-|-Moulton|l1' 'Adams-|-Moulton|l2' };
RowsName = {'1/2' '1/4' '1/8' '1/16' '1/32'};
SecondMode = TableMode( CoulmnsName, RowsName  );
TestTable.addMode( SecondMode );

% pring a table with new mode
TestTable.addTable( UsersData, 'Title' );
