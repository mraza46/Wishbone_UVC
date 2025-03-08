class wishbone_spi_test extends uvm_test;
    `uvm_component_utils(wishbone_spi_test)

    wishbone_agent wb_agent;
    spi_agent spi_agent;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        wb_agent = wishbone_agent::type_id::create("wb_agent", this);
        spi_agent = spi_agent::type_id::create("spi_agent", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        wishbone_write_seq wb_wr_seq;
        wishbone_read_seq wb_rd_seq;
        spi_write_seq spi_wr_seq;
        spi_read_seq spi_rd_seq;

        phase.raise_objection(this);

        wb_wr_seq = wishbone_write_seq::type_id::create("wb_wr_seq");
        wb_rd_seq = wishbone_read_seq::type_id::create("wb_rd_seq");
        spi_wr_seq = spi_write_seq::type_id::create("spi_wr_seq");
        spi_rd_seq = spi_read_seq::type_id::create("spi_rd_seq");

        wb_wr_seq.start(wb_agent.seqr);
        wb_rd_seq.start(wb_agent.seqr);
        spi_wr_seq.start(spi_agent.seqr);
        spi_rd_seq.start(spi_agent.seqr);

        phase.drop_objection(this);
    endtask
endclass