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
        if(!uvm_config_db#(virtual fpu_if)::get(this,"","vif",cfg.intrf))
            `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG FILE")
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
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_addition::type_id::create("seq");
        repeat(500000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass

/////////////////////////////////////////////////////////////////////////

class normal_subtraction_test extends test;

    `uvm_component_utils(normal_subtraction_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normal_subtraction seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_subtraction::type_id::create("seq");
        repeat(500000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass



class normal_inf_test extends test;

    `uvm_component_utils(normal_inf_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normal_inf seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_inf::type_id::create("seq");
        repeat(500000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class normal_overflow_test extends test;

    `uvm_component_utils(normal_overflow_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normal_overflow seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_overflow::type_id::create("seq");
        repeat(500) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class normal_underflow_test extends test;

    `uvm_component_utils(normal_underflow_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normal_underflow seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_underflow::type_id::create("seq");
        repeat(500) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class normal_zero_test extends test;

    `uvm_component_utils(normal_zero_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normal_zero seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_zero::type_id::create("seq");
        repeat(5000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class write_en_high_test extends test;

    `uvm_component_utils(write_en_high_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    write_en_high seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = write_en_high::type_id::create("seq");
        repeat(500) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class normal_NAN_test extends test;

    `uvm_component_utils(normal_NAN_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normal_NAN seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normal_NAN::type_id::create("seq");
        repeat(500) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class reset_in_between_test extends test;

    `uvm_component_utils(reset_in_between_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    reset_in_between seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = reset_in_between::type_id::create("seq");
        repeat(100) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class subnormal_test extends test;

    `uvm_component_utils(subnormal_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    subnormal seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = subnormal::type_id::create("seq");
        repeat(1000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass

class operand1_zero_test extends test;

    `uvm_component_utils(operand1_zero_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    operand1_zero seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = operand1_zero::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class operand2_zero_test extends test;

    `uvm_component_utils(operand2_zero_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    operand2_zero seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = operand2_zero::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class signed_addition_test extends test;

    `uvm_component_utils(signed_addition_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    signed_addition seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = signed_addition::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class addition_8_write_test extends test;

    `uvm_component_utils(addition_8_write_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    addition_8_write seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = addition_8_write::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class read_delay_test extends test;

    `uvm_component_utils(read_delay_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    read_delay seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = read_delay::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass



class ena_toggle_test extends test;

    `uvm_component_utils(ena_toggle_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    ena_toggle seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = ena_toggle::type_id::create("seq");
        repeat(1000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass

class read_only_test extends test;

    `uvm_component_utils(read_only_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    read_only seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = read_only::type_id::create("seq");
        repeat(100000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class write_read_11_test extends test;

    `uvm_component_utils(write_read_11_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    write_read_11 seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = write_read_11::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass

class normalization_test extends test;

    `uvm_component_utils(normalization_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    normalization seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = normalization::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class write_busy_test extends test;

    `uvm_component_utils(write_busy_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    write_busy seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = write_busy::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class error_recover_test extends test;

    `uvm_component_utils(error_recover_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    error_recover seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);
        //normal addition
        seq2 = error_recover::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass



class start_pulse_test extends test;

    `uvm_component_utils(start_pulse_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    start_pulse seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        //reset
        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);

        seq2 = start_pulse::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass


class multiple_addition_test extends test;

    `uvm_component_utils(multiple_addition_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    multiple_addition seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);

        seq2 = multiple_addition::type_id::create("seq");
        repeat(10000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass

class add_sub_test extends test;

    `uvm_component_utils(add_sub_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    add_sub seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);

        seq2 = add_sub::type_id::create("seq");
        repeat(100000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass
///////////////////////////////////////////////////////////////////////////

class read_busy_test extends test;

    `uvm_component_utils(read_busy_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    read_busy seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);

        seq2 = read_busy::type_id::create("seq");
        repeat(50000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass

class write_read_busy_test extends test;

    `uvm_component_utils(write_read_busy_test)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    reset_seq seq1;
    write_read_busy seq2;

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        seq1 = reset_seq::type_id::create("seq");
        repeat(1) seq1.start(environment.ia.sqr);

        seq2 = write_read_busy::type_id::create("seq");
        repeat(100000) seq2.start(environment.ia.sqr);
        #500ns;
        phase.drop_objection(this);
    endtask

endclass
