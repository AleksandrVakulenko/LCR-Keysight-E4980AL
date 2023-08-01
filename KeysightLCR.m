

% dofixrpt('Ammeter.m','file')
% dofixrpt(dir)

classdef KeysightLCR < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)
        function obj = KeysightLCR()
            vias_adr = find_E4980AL();
            if ~isempty(vias_adr)
%                 'USB0::0x2A8D::0x2F01::MY54305367::INSTR'
				%TODO: add variants on VISA vendor
                obj.visa_dev = visa('ni',vias_adr); %new visadev is bad, we use old

            else
                error('connection error');
            end

        end
        
        function delete(obj)
             delete(obj.visa_dev); %FIXME: use it or not?
             disp("KeysightLCR DELETED"); %UNUSED
        end

    
        function volt_out = set_volt(obj, volt_in)
            obj.send(obj.visa_dev, [':VOLTage:LEVel ' num2str(volt_in)]);
            response = obj.query(obj.visa_dev, ':VOLTage:LEVel?');
            data = sscanf(response, '%f');
            volt_out = data(1);
        end


        function freq_out = set_freq(obj, freq_in)
            obj.send(obj.visa_dev, [':FREQuency:CW ' num2str(freq_in)]);
            response = obj.query(obj.visa_dev, ':FREQuency:CW?');
            data = sscanf(response, '%f');
            freq_out = data(1);
        end


        function [cap_re, tan_d] = get_res(obj)
            response = obj.query(obj.visa_dev, ':FETCh:IMPedance:CORrected?');
            data = sscanf(response, '%f,%f');
            cap_re = data(1);
            tan_d = data(2);
        end


        function [res_re, res_im] = get_cap(obj)
            response = obj.query(obj.visa_dev, ':FETCh:IMPedance:FORmatted?');
            data = sscanf(response, '%f,%f');
            res_re = data(1);
            res_im = data(2);
        end


        function set_speed(obj, arg, count)
            count = uint8(count);
            switch lower(arg)
                case 's'
                    CMD = [':APERture SHORt, ' num2str(count)];
                case 'm'
                    CMD = [':APERture MEDium, ' num2str(count)];
                case 'l'
                    CMD = [':APERture LONG, ' num2str(count)];
                otherwise
                    CMD = ':APERture MEDium, ';
            end
            obj.send(obj.visa_dev, CMD);
        end


    end
    
    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        visa_dev = [];
        send_data_timeout = 0.2; %s
    end
    
    methods (Access = private)
        function send(ojb, dev, CMD)
            fopen(dev);
            fprintf(dev, CMD);
            fclose(dev);
        end

        function response = query(obj, dev, CMD)
            fopen(dev);
            fprintf(dev, CMD);
            response = fscanf(dev);
            fclose(dev);
        end
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












