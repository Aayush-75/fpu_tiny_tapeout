class scorboard extends uvm_scorebaord;

    `uvm_component_utils(scoreboard)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    uvm_tlm_analysis_fifo#(seq_item) ip_fifo;
    uvm_tlm_analysis_fifo#(seq_item) op_fifo;

    seq_item ip;
    seq_item op;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ip_fifo = new("input fifo",this);
        op_fifo = new("output fifo",this);
    endfunction

    task run_phse(uvm_phase phase);
        forever 
        begin
            ip_fifo.get(ip);
            op_fifo.get(op);
            ref_task();
            chekk();    
        end
    endtask

    task ref_task();

    endtask

    task checkk();

    endtask

endclass
