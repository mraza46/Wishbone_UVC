// SPI Monitor
class spi_monitor extends uvm_monitor;
    virtual spi_if spi_if;
    uvm_analysis_port #(spi_transaction) mon_ap;

    `uvm_component_utils(spi_monitor)
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        mon_ap = new("mon_ap", this);
        if (!uvm_config_db#(virtual spi_if)::get(this, "", "spi_if", spi_if))
            `uvm_fatal("MONITOR", "No interface found!")
    endfunction

    virtual task run_phase(uvm_phase phase);
        spi_transaction txn;
        forever begin
            @(posedge spi_if.sck);
            txn = spi_transaction::type_id::create("txn");
            txn.rx_data = spi_if.miso;
            mon_ap.write(txn);
        end
    endtask
endclass