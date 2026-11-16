class my_driver extends uvm_driver#(seq_item);

    `uvm_component_utils(my_driver)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual fpu_if intrf;
    fpu_cfg cfg;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(fpu_cfg)::get(this,"","cfg",cfg)))
            `uvm_fatal(get_type_name(),"failed to get config file")
    endfunction

    function void connectt_phase(uvm_phase phase);
        super.connect_phase(phase);
        intrf = cfg.intrf;
    endfunction

    task run_phase(uvm_phase phase);
        @(intrf.drv_cb);
        forever
        begin
            seq_item_port.get_next_item(req);
            drive();
            seq_item_port.item_done();
        end
    endtask

    task drive();
        intrf.drv_mod.drv_cb.rst_n <= req.rst_n;
        intrf.drv_mod.drv_cb.ena <= req.ena;
        intrf.drv_mod.drv_cb.ui_in <= req.ui_in;
        intrf.drv_mod.drv_cb.uio_in <= req.uio_in;
        @(intrf.drv_cb);
    endtask

endclass
