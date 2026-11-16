class test extends uvm_test;

    `uvm_component_utils(test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    fpu_cfg cfg;
    env environment;
    my_sequence seq;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg = fpu_cfg::type_id::create("config file",this);
        environment = env::type_id::create("environment",this);
        cfg.ip_agent = UVM_ACTIVE;
        cfg.op_agent = UVM_PASSIVE;
        uvm_config_db#(fpu_cfg)::set(this,"*","cfg",cfg);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

endclass

class reset_test extends test;

    `uvm_component_utils(reset_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(5) seq1.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass

class normal_addition_test extends test;

    `uvm_component_utils(normal_addition_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normal_addition seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(5) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_addition::type_id::create("seq");
        repeat(15) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass
