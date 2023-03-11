
% TODO:
%  1) 
%  2) 



% To find all FIXME, TODO, NOTE use:
% dofixrpt('Ammeter.m','file') -> find notes in file
% dofixrpt(dir) -> find notes in all files in directory 'dir'

classdef KeysightLCR < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)

    end
    
    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        COM_port_str = '';
        Serial_obj = [];
        Wait_data_timeout = 1; %s
    end
    
    methods (Access = private)

    end
    
end







