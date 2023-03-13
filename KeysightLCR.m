
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
            close_all_KeysightLCR();
            obj.visa_dev = connect();
            if isempty(obj.visa_dev)
                error('connection error');
            end
%             set(obj.visa_dev, 'Timeout', 4)
        end
        
        function delete(obj)
            disp("DELETED"); %FIXME: debug
        end

    
        function volt_out = set_volt(obj, volt_in)
            writeline(obj.visa_dev, [':VOLTage:LEVel ' num2str(volt_in)]);
            response = writeread(obj.visa_dev, ':VOLTage:LEVel?');
            data = sscanf(response, '%f');
            volt_out = data(1);
        end


        function freq_out = set_freq(obj, freq_in)
            writeline(obj.visa_dev, [':FREQuency:CW ' num2str(freq_in)]);
            response = writeread(obj.visa_dev, ':FREQuency:CW?');
            data = sscanf(response, '%f');
            freq_out = data(1);
        end


        function [cap_re, tan_d] = get_cap(obj) % FIXME: placeholder
            response = writeread(obj.visa_dev, ':FETCh:IMPedance:CORrected?');
            data = sscanf(response, '%f,%f');
            cap_re = data(1);
            tan_d = data(2);
        end


        function [res_re, res_im] = get_res(obj) % FIXME: placeholder
%             response = writeread(obj.visa_dev, ':FETCh:IMPedance:FORmatted?');
%             data = sscanf(response, '%f,%f');
%             res_re = data(1);
%             res_im = data(2);

            writeline(obj.visa_dev, ':FETCh:IMPedance:FORmatted?');
            pause(0.2); %FIXME: magic constant
            response = readline(obj.visa_dev);
            data = sscanf(response, '%f,%f');
            res_re = data(1);
            res_im = data(2);

            flush(obj.visa_dev);
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





function close_all_KeysightLCR()
input_class_name = 'KeysightLCR';
baseVariables = evalin('base' , 'whos');
Indexes = string({baseVariables.class}) == input_class_name;
Var_names = string({baseVariables.name});
Var_names = Var_names(Indexes);
Valid = zeros(size(Var_names));
for i = 1:numel(Var_names)
    Valid(i) = evalin('base', ['isvalid(' char(Var_names(i)) ')']);
end
Valid = logical(Valid);
Var_names = Var_names(Valid);
for i = 1:numel(Var_names)
    evalin('base', ['delete(' char(Var_names(i)) ')']);
end
end












