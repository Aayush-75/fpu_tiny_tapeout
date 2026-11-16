class my_sequence extend uvm_sequence#(seq_item);

    static longint count;

    `uvm_object_utils(reset_seq)
    
    function new(string name="");
        super.new(name);
    endfunction

endclass

class reset_seq extends my_sequence;

    `uvm_object_utils(reset_seq)
    
    function new(string name="");
        super.new(name);
    endfunction

    task body();
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n = 0;
        }
        finish_item(req);
    endtask

endclass

class normal_addition extends my_sequence;

    `uvm_object_utils(normal_addition)
    
    function new(string name="");
        super.new(name);
    endfunction

    function void post_randomize();
        if(count==13)
            count=0;
        count++;
    endfunction

    task body();
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n = 1;
            //write_en
            if((count==0) || (count==2) || (count==4) || (count==6))
            {
                ui_in[0] == 1;
            }
            else
            {
                ui_in[0] == 0;
            }
            //read_en
            if((count==11) || (count==13))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            //start
            if(count==7)
            {
                ui_in[2] == 1;
            }
            //start
            if(count==7)
            {
                ui_in[3] == 0;
            }
        }
        finish_item(req);
    endtask

endclass
