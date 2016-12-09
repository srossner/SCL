classdef Cursor < handle

    properties %( Access = private )
        PointX = 0;
        PointY = 0;
    end
    
    % Public methods
    methods
	% Constructor 
        function Obj = Cursor( PointX, PointY )
            Obj.setCursorPosition( PointX, PointY );
        end
        
        function setCursorPosition( Obj, PointX, PointY )
            Obj.PointX = PointX;
            Obj.PointY = PointY;
        end
       
        
        function setXPosition( Obj, PointX )
            Obj.PointX = PointX;
        end
       
        
        function setYPosition( Obj, PointY )
            Obj.PointY = PointY;
        end
        
        
        function PointX = getPointX( Obj )
            PointX = Obj.PointX;
        end
        
        
        function PointY = getPointY( Obj )
            PointY = Obj.PointY;
        end
        
    end
    
end