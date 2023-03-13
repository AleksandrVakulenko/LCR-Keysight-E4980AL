function dev = connect()
    vias_adr = find_E4980AL();
    if vias_adr ~= ""
        dev = visadev(vias_adr);
        [tf, status] = visastatus(dev);
        response = writeread(dev, '*IDN?');
    else
        dev = [];
        disp('No device');
    end
end