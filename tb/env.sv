class module_uvc extends uvm_env;
    wishbone_agent wb_agent;
    spi_agent spi_agent;

    `uvm_component_utils(module_uvc)
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        wb_agent = wishbone_agent::type_id::create("wb_agent", this);
        spi_agent = spi_agent::type_id::create("spi_agent", this);
    endfunction
endclass
