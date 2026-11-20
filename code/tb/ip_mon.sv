class ip_mon extends uvm_monitor;

    `uvm_component_utils(ip_mon);

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual fpu_if intrf;
    fpu_cfg cfg;
    seq_item req;
    uvm_analysis_port#(seq_item) ip_analysis_port;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(fpu_cfg)::get(this,"","cfg",cfg)))
            `uvm_fatal(get_type_name(),"failed to get config file")
        ip_analysis_port = new("ip_analysis_port",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        intrf = cfg.intrf;
    endfunction

    task run_phase(uvm_phase phase);
        repeat(2) @(intrf.ip_mon_cb);
        forever
        begin
            req = seq_item::type_id::create("seq");
            req.rst_n = intrf.ip_mon_mod.ip_mon_cb.rst_n;
            req.ena = intrf.ip_mon_mod.ip_mon_cb.ena;
            req.ui_in = intrf.ip_mon_mod.ip_mon_cb.ui_in;
            req.uio_in = intrf.ip_mon_mod.ip_mon_cb.uio_in;
            ip_analysis_port.write(req);
            @(intrf.ip_mon_cb);
        end
    endtask

endclass

