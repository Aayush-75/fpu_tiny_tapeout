class op_mon extends uvm_monitor;

    `uvm_component_utils(op_mon);

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    fpu_if intrf;
    fpu_cfg cfg;
    seq_item req;
    uvm_analysis_port#(seq_item) op_analysis_port;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(fpu_cfg)::get(this,"","cfg",cfg)))
            `uvm_fatal(get_type_name(),"failed to get config file")
        op_analysis_port = new("op_analysis_port",this);
    endfunction

    function void conncet_phase(uvm_phase phase);
        super.conncet_phase(phase);
        intrf = cfg.intrf;
    endfunction 

    task tun_phase(uvm_phase phase);
        repeat(2) @(intrf.op_mon_cb);
        forever 
        begin
            req.uo_out = intrf.op_mon_mod.op_mon_cb.uo_out;
            req.uio_out = intrf.op_mon_mod.op_mon_cb.uio_out;
            req.uio_oe = intrf.op_mon_mod.op_mon_cb.uio_oe;
            op_analysis_port.write(req);
            @(intrf.op_mon_cb);
        end
    endtask

endclass
