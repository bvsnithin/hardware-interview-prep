class my_coverage extends uvm_component;
    `uvm_component_utils(my_coverage)

    uvm_analysis_imp #(my_item, my_coverage) analysis_export;

    my_item tr_coverage;

    covergroup cg;
        cp_addr: coverpoint tr_coverage.addr{
            bins bins_low_addr = {[8'h00:8'h55]};
            bins bins_middle_addr = {[8'h56:8'hAA]};
            bins bins_high_addr = {[8'hAB:8'hFF]};
        }

        cp_data: coverpoint tr_coverage.data{
            bins bins_low_data = {[8'h00:8'h55]};
            bins bins_middle_data = {[8'h56:8'hAA]};
            bins bins_high_data = {[8'hAB:8'hFF]};
        }
        
        x_data_addr: cross cp_addr, cp_data;
    endgroup

    function new(string name ="my_coverage", uvm_component parent);
        super.new(name,parent);
        analysis_export = new("analysis_export", this);
        cg = new();
    endfunction

    virtual function void write(my_item tr);
        tr_coverage = tr;
        cg.sample();
    endfunction
endclass: my_coverage