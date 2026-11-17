class env extends uvm_env;

    `uvm_component_utils(env)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    ip_agent ia;
    op_agent oa;
    scoreboard scb;
     fpu_subscriber sub;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ia = ip_agent::type_id::create("input agent",this);
        oa = op_agent::type_id::create("output agent",this);
        scb = scoreboard::type_id::create("scoreboard",this);
         sub = fpu_subscriber::type_id::create("subscriber",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        ia.im.ip_analysis_port.connect(scb.ip_fifo.analysis_export);
        oa.om.op_analysis_port.connect(scb.op_fifo.analysis_export);
         ia.im.ip_analysis_port.connect(sub.analysis_export);
    endfunction

endclass
