classdef SpecificTable < handle

    properties ( Constant, Access = private )
    % WINDOW_CONSTANT
        X_INITIAL_WINDOW_POSITION = 100;
        Y_INITIAL_WINDOW_POSITION = 100;
        WINDOW_HEIGHT = 600;
        WINDOW_WIDTH = 1000;
        Y_OFFSET = 30;
        X_OFFSET = 10
    end
    
    properties %( Access = protected )
        Mode = 'None';
        NumberLeftTables = 0;
        Table = 0;
        TableName = 0;
        TableWidth = 0;
        TableHeight = 0;
        TableWindow = 0;
        CoulmnsName = {};
        RowsName = {};
    end
    
    methods
        % Constructor 
        function Object = SpecificTable( SpecificMode )
            
            % Initialize necessary variable
            Object.setTableMode( SpecificMode );
            
            % Create a window with appropriate size
            Object.TableWindow = figure;
            set( Object.TableWindow, 'Position', ...
                   [ Object.X_INITIAL_WINDOW_POSITION ...
                     Object.Y_INITIAL_WINDOW_POSITION ...
                     Object.WINDOW_WIDTH ...
                     Object.WINDOW_HEIGHT ] );
               
        end % Function End
        
        % Set an appropriate table mode
        function setTableMode( Object, SpecificMode )
            if ( strcmp( SpecificMode, 'LeftMode' ) == true )
               Object.initLeftMode();
            elseif ( strcmp( SpecificMode, 'RightMode' ) == true )
               Object.initRightMode();
            else
                Object.Mode = 'None';
            end
        end % Function End
        
        % change mode from left to right and vise versa
        function changeMode( Object )
            if ( strcmp( Object.Mode, 'LeftMode' ) == true )
               Object.Mode = 'RightMode';
               %fprintf('The current mode is: %s\n', Object.Mode );
            elseif ( strcmp( Object.Mode, 'RightMode' ) == true )
               Object.Mode = 'LeftMode';
               %fprintf('The current mode is: %s\n', Object.Mode );
            else
                disp('The initial mode has not been set');
            end
        end % Function End
        
               
        function addTable( Object, Data )
            if ( strcmp( Object.Mode, 'LeftMode' ) == true )
                
               Object.depictLeftTable( Data )
            elseif ( strcmp( Object.Mode, 'RightMode' ) == true )

               Object.depictRightTable( Data )
            else
               disp('Error: a mode is not set yet');
            end
        end
        
    end % Methods end
    
    methods ( Access = protected )
        
        % Initialization of the Left Mode
        function initLeftMode( Object )
            Object.Mode = 'LeftMode';
            Object.CoulmnsName = {'1/2' '1/4' '1/8' '1/16' '1/32'};
            Object.RowsName = {'Error', 'Error red.'};
            Object.TableWidth = 490;
            Object.TableHeight = 60;
        end % Function End
        
        
        % Initialization of the Left Mode
        function initRightMode( Object )
            Object.Mode = 'RightMode';
            Object.CoulmnsName = {'explcit Euler' 'Heun' ...
                                    'implicit Euler' 'Adams-Moulton' ...
                                    'Adams-Moulton l1' 'Adams-Moulton l2' };
            Object.RowsName = {'1/2' '1/4' '1/8' '1/16' '1/32'};

            %Object.TableWidth = 490
            %Object.TableHeight = 60
        end % Function End
              
        
        
        function depictLeftTable( Object, Data )
            Object.NumberLeftTables = Object.NumberLeftTables + 1;
            i = Object.NumberLeftTables;
            
            % Draw the table
            Object.Table(i) = uitable( Object.TableWindow );
            set( Object.Table(i), 'Data', Data );
            set( Object.Table(i), 'ColumnName', Object.CoulmnsName );
            set( Object.Table(i), 'RowName', Object.RowsName );
            set( Object.Table(i), 'Position', ...
                    [ Object.X_OFFSET ....
                    ( Object.WINDOW_HEIGHT -i * ( Object.Y_OFFSET + Object.TableHeight ) ) ...
                    Object.TableWidth ...
                    Object.TableHeight ] );
           Object.TableName(i) = uicontrol( Object.TableWindow );
           
           % Write the table title
           Title = Object.getTitle( i );
           set(Object.TableName(i), 'Style','Text' );
           set(Object.TableName(i), 'String', Title );
           set(Object.TableName(i), 'Position', ...
                    [ Object.X_OFFSET ....
                    ( Object.WINDOW_HEIGHT - Object.Y_OFFSET ...
                            - ( i - 1 ) * ( Object.TableHeight + Object.Y_OFFSET ) ) ...
                    Object.TableWidth ...
                    15 ] );
        end
        
        function depictRightTable( Object, Data )
            Object.NumberLeftTables = Object.NumberLeftTables + 1;
            i = Object.NumberLeftTables;
            
            % Draw the table
            Object.Table(i) = uitable( Object.TableWindow );
            set( Object.Table(i), 'Data', Data );
            set( Object.Table(i), 'ColumnName', Object.CoulmnsName );
            set( Object.Table(i), 'RowName', Object.RowsName );
            set( Object.Table(i), 'Position', ...
                    [ ( Object.WINDOW_WIDTH / 2 ) + Object.X_OFFSET ....
                      (  Object.WINDOW_WIDTH / 2 ) ...
                    Object.TableWidth ...
                    Object.TableHeight ] );
           Object.TableName(i) = uicontrol( Object.TableWindow );
           
        end
        
        
        function Title = getTitle( Object, Index )
            if ( strcmp( Object.Mode, 'LeftMode' ) == true )
                switch ( Index )
                    case 1
                        Title = 'explicit  Euler';
                    case 2
                        Title = 'Heun';
                    case 3
                        Title = 'implicit  Euler';
                    case 4
                        Title = 'Adams  Moulton';
                    case 5
                        Title = 'Adams  Moulton - linearisation 1';
                    case 6
                        Title = 'Adams  Moulton - linearisation 2';
                    otherwise
                        Title = 'Default';
                end
            else
                Title = 'Stable cases';
            end
        end
        
    end % Methods end

    
    
end % Class End