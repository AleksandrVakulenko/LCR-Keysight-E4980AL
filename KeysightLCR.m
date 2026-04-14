

classdef KeysightLCR < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)
        function obj = KeysightLCR(Serial_number)
            arguments
                Serial_number = []
            end
            [vias_adr, SN] = find_visa_dev_by_name("E4980AL", Serial_number);
            if ~isempty(vias_adr)
				%TODO: add variants on VISA vendor
                obj.visa_dev = visa('ni', vias_adr); %new visadev is bad, we use old
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


        function [res_re, res_im] = get_res(obj)
            response = obj.query(obj.visa_dev, ':FETCh:IMPedance:CORrected?');
            data = sscanf(response, '%f,%f');
            res_re = data(1);
            res_im = data(2);
        end


        function [cap_re, tan_d] = get_cap(obj)
            response = obj.query(obj.visa_dev, ':FETCh:IMPedance:FORmatted?');
            data = sscanf(response, '%f,%f');
            cap_re = data(1);
            tan_d = data(2);
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







function [vias_adr, SerialNumber] = find_visa_dev_by_name(name, SerialNumber)
arguments
    name string
    SerialNumber = [];
end
    dev_table = visadevlist;
    ind = find(dev_table.Model == name);

    if ~isempty(ind)
        if ~isempty(SerialNumber)
            SerialNumber = string(SerialNumber);
            ind2 = find(dev_table.SerialNumber == SerialNumber);
            if any(ind == ind2)
                vias_adr = dev_table.ResourceName(ind2);
            else
                Str = get_dev_list_str(dev_table);
                error(['No device "' char(name) '"' ' with SN:' ...
                    char(SerialNumber) ' in list: ' newline Str]);
            end
        else % no SERIAL NUMBER is provided:
            if numel(ind) == 1
                vias_adr = dev_table.ResourceName(ind);
            else
                Str = get_dev_list_str(dev_table);
                error(['the choice of device ' '"' char(name) '"' ...
                    ' is ambiguous:' newline Str]);
            end
        end
    else
        Str = get_dev_list_str(dev_table);
        error(['No device "' char(name) '" in list: ' newline Str]);
    end

end


function Str = get_dev_list_str(dev_table)
    arguments
        dev_table = [];
    end

    if isempty(dev_table)
        dev_table = visadevlist;
    end
    Str = '';
    for i = 1:size(dev_table, 1)
        Str = [Str num2str(i) '| ' ...
               char(dev_table{i, "Vendor"}) ' | ' ...
               char(dev_table{i, "Model"})  ' | ' ...
               char(dev_table{i, "SerialNumber"}) newline];
    end
end








