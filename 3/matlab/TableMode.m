classdef TableMode < handle
	properties %( Access = private )
        CoulmnsName = {};
        RowsName = {};
        
        ColumnHeight = 25;
        ColumnWidth = 75;
        
        TableHeight = 0;
        TotalTableHeight = 0;
        TableWidth = 0;
        
        TitleHeight = 20;
        
    end
    
    % Public methods
    methods
        function Obj = TableMode( CoulmnsName, RowsName )
            Obj.CoulmnsName = CoulmnsName;
            Obj.RowsName = RowsName;
            Obj.updateData();
        end
        
        
        function setCoulmnsName( Obj, CoulmnsName )
            Obj.CoulmnsName = CoulmnsName;
            Obj.updateData();
        end
        
        
        function setRowsName( Obj, RowsName )
            Obj.RowsName = RowsName;
            Obj.updateData();
        end
         
        
    	 function setColumnWidth( Obj, Width )
            Obj.ColumnWidth = Width;
            Obj.updateData();
         end
        
        
        function setColumnHeight( Obj, Height )
            Obj.ColumnHeight = Height;
            Obj.updateData();
        end
        
        
        function setTitleHeight( Obj, TitleHeight )
            Obj.TitleHeight = TitleHeight;
            Obj.updateData();
        end
        
        
        function ColumnWidth = getColumnWidth( Obj )
            ColumnWidth = Obj.ColumnWidth;
        end
        
      
        function TableWidth = getTableWidth( Obj )
            TableWidth = Obj.TableWidth;
        end
        
        
        function TableHeight = getTableHeight( Obj )
            TableHeight = Obj.TableHeight;
        end
        
        
        function TotalTableHeight = getTotalTableHeight( Obj )
            TotalTableHeight = Obj.TotalTableHeight;
        end
        
        
        function TitleHeight = getTitleHeight( Obj )
            TitleHeight = Obj.TitleHeight;
        end
        
        function ColumnNames = getColumnNames( Obj )
            ColumnNames = Obj.CoulmnsName;
        end
        
        
        function RowNames = getRowNames( Obj )
            RowNames = Obj.RowsName;
        end
        
    end
    
    
    % Private methods
    methods ( Access = protected )
        function updateData( Obj )
            Obj.TableWidth = Obj.ColumnWidth * ( length( Obj.CoulmnsName ) + 1 ); 
            Obj.TableHeight = Obj.ColumnHeight * ( length( Obj.RowsName ) + 1 );
            Obj.TotalTableHeight = Obj.TableHeight + Obj.TitleHeight;
        end
    end
    
    
end