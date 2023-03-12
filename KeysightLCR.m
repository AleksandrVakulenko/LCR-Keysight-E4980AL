
% TODO:
%  1) 
%  2) 


% To find all FIXME, TODO, NOTE use:
% dofixrpt('Ammeter.m','file') -> find notes in file
% dofixrpt(dir) -> find notes in all files in directory 'dir'

classdef KeysightLCR < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)
        function obj = KeysightLCR()
            
        end
        
        function delete(obj)
            disp("DELETED"); %FIXME: debug
        end

        function res = get_res(obj) % FIXME: placeholder
            res = 997; %Ohm
        end
    end
    
    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        visa_dev = [];
        send_data_timeout = 0.2; %s
    end
    
    methods (Access = private)

    end
    
end







