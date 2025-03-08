// SPI Driver
class spi_driver extends uvm_driver #(spi_transaction);
    virtual spi_if spi_if;

    `uvm_component_utils(spi_driver)
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual spi_if)::get(this, "", "spi_if", spi_if))
            `uvm_fatal("DRIVER", "No interface found!")
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            @(posedge spi_if.sck);
            spi_if.mosi <= req.tx_data[7];
            seq_item_port.item_done();
        end
    endtask
endclass