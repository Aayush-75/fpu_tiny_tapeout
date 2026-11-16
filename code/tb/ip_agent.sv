class ip_agent extends uvm_agent;

    `uvm_component_utils(ip_agent)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    my_driver drv;
    my_sequencer sqr;
    ip_mon im;
    fpu_cfg cfg;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(fpu_cfg)::get(this,"","cfg",cfg)))
            `uvm_fatal(get_type_name(),"failed to get confgi file")
        im = ip_mon::type_id::create("input monitor",this);
        if(cfg.ip_agent==UVM_ACTIVE)
        begin
            drv = my_driver::type_id::create("drive",this);
            sqr = my_sequencer::type_id::create("sequencer",this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction

endclass
