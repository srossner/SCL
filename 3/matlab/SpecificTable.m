classdef SpecificTable < handle

    properties ( Constant, Access = private )
    % WINDOW_CONSTANT
        X_INITIAL_WINDOW_POSITION = 200;
        Y_INITIAL_WINDOW_POSITION = 50;
        WINDOW_HEIGHT = 550;
        WINDOW_WIDTH = 1010;
        Y_OFFSET = 10;
        X_OFFSET = 10
    end
    
    properties %( Access = protected )
        FigureName = 'None';
        Modes = [];
        CurrentModeIndex = 0;
        NumberTables = 0;
        
        Table = 0;
        TableName = 0;
        TableWindow = 0;
        CurrentCursor = 0;
        ScreenFull = false;
    end
    
     % Public methods
     methods
        % Constructor 
        function Obj = SpecificTable( FigureName )
            Obj.FigureName = FigureName;
            Obj.TableWindow = figure;
            set( Obj.TableWindow, 'Name', FigureName );
            set( Obj.TableWindow, 'Position', ...
                [ Obj.X_INITIAL_WINDOW_POSITION ...
                    Obj.Y_INITIAL_WINDOW_POSITION ...
                    Obj.WINDOW_WIDTH ...
                    Obj.WINDOW_HEIGHT ] );
                
             Obj.initCursor();    
        end
        
        
        function addMode( Obj, aMode )
            Obj.Modes = [ Obj.Modes aMode ];
            Obj.CurrentModeIndex = Obj.CurrentModeIndex + 1;
            
        end
        
        
        function addTable( Obj, Data, Title )
            % Without protection
            Obj.NumberTables = Obj.NumberTables + 1;
            i = Obj.NumberTables;
            
            
            Obj.moveCorsur( Obj.Modes( Obj.CurrentModeIndex ).getTotalTableHeight() );
            if ( Obj.ScreenFull == true )
                disp(' There is no space left on the screen for the next table ');
                return;
            end
            
            
            % Draw the table
            Obj.Table(i) = uitable( Obj.TableWindow );      
            set( Obj.Table(i), 'Data', Data );
            set( Obj.Table(i), 'ColumnName', Obj.Modes( Obj.CurrentModeIndex ).getColumnNames() );
            set( Obj.Table(i), 'RowName', Obj.Modes( Obj.CurrentModeIndex ).getRowNames() );
            
            % Magic Namber 65 means the Solumn Width. The problem might be
            % solved in the next release.
            set( Obj.Table(i), 'ColumnWidth', { 65 } );
            
            set( Obj.Table(i), 'Position', ...
                    [ Obj.CurrentCursor.getPointX() ....
                      Obj.CurrentCursor.getPointY() ... 
                      Obj.Modes( Obj.CurrentModeIndex ).getTableWidth() ...
                      Obj.Modes( Obj.CurrentModeIndex ).getTableHeight() ] );
                  

            % Write the table title
           %Title = Object.getTitle( i );
           Obj.TableName(i) = uicontrol( Obj.TableWindow );
           set(Obj.TableName(i), 'Style','Text' );
           set(Obj.TableName(i), 'String', Title );
           set(Obj.TableName(i), 'Position', ...
                    [ Obj.CurrentCursor.getPointX() ....
                      Obj.CurrentCursor.getPointY() ...
                                + Obj.Modes( Obj.CurrentModeIndex ).getTableHeight()  ...
                      Obj.Modes( Obj.CurrentModeIndex ).getTableWidth() ...
                      Obj.Modes( Obj.CurrentModeIndex ).getTitleHeight() ] );
            
        end
        
        
        function chooseMode( Obj, ModeIndex )
            if ( ( ModeIndex < 1 ) || ( ModeIndex > Obj.CurrentModeIndex ) )
                disp( 'Error: the intex is out of the range' );
                return;
            end
            Obj.CurrentModeIndex = ModeIndex;
            
        end
        
        
        function ModesNumber = getModesNumber( Obj )
            ModesNumber = length( Obj.Modes );
        end
    
        
        function CurrentModeIndex = getCurrentModeIndex( Obj )
            CurrentModeIndex = Obj.CurrentModeIndex;
        end
        
     end
     
     methods ( Access = private )
         function initCursor( Obj )
             Obj.CurrentCursor = Cursor( 0, 0 );
             Obj.CurrentCursor.setXPosition( Obj.X_OFFSET );
             Obj.CurrentCursor.setYPosition( Obj.WINDOW_HEIGHT - Obj.Y_OFFSET );
         end
         
         
         function moveCorsur( Obj, VertivalDistance )
             FutherMoveY = Obj.CurrentCursor.getPointY() - VertivalDistance - Obj.Y_OFFSET;
             if ( FutherMoveY < Obj.Y_OFFSET )
                 
                 FutherMoveX = Obj.CurrentCursor.getPointX() ...
                     + ( Obj.WINDOW_WIDTH / 2 );
                 if ( FutherMoveX > Obj.WINDOW_WIDTH )
                     Obj.ScreenFull = true;
                     return;
                 end
                 
                 Obj.CurrentCursor.setXPosition( FutherMoveX );
                 Obj.CurrentCursor.setYPosition( Obj.WINDOW_HEIGHT ...
                      - 2 * Obj.Y_OFFSET - VertivalDistance );
                 return;
             end
             
             Obj.CurrentCursor.setYPosition( FutherMoveY );
         end
     end
end