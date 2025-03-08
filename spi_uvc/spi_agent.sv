// SPI Agent
class spi_agent extends uvm_agent;
    spi_driver drv;
    spi_monitor mon;
    uvm_sequencer #(spi_transaction) seqr;

    `uvm_component_utils(spi_agent)
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        drv = spi_driver::type_id::create("drv", this);
        mon = spi_monitor::type_id::create("mon", this);
        seqr = uvm_sequencer#(spi_transaction)::type_id::create("seqr", this);
    endfunction
endclass