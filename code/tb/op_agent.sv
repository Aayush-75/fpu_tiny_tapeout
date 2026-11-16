class op_agent extends uvm_agent;

    `uvm_component_utils(op_agent)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    ip_mon om;
    fpu_cfg cfg;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(fpu_cfg)::get(this,"","cfg",cfg)))
            `uvm_fatal(get_type_name(),"failed to get confgi file")
        om = op_mon::type_id::create("output monitor",this);
    endfunction
    
endclass
