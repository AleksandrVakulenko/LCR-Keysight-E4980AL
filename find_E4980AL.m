function vias_adr = find_E4980AL()
    dev_table = visadevlist;
    ind = find(dev_table.Model == "E4980AL");
    if ~isempty(ind)
        vias_adr = dev_table.ResourceName(ind);
    else
        vias_adr = "";
    end
end