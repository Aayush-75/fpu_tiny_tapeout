class seq_item extends uvm_seq_item;

    `uvm_object_utils(seq_item)

    function new(string name="");
        super.new(name);
    endfunction 

    static longint count,needed_count;

    /////////////input 
    rand bit rst_n;
    rand bit ena;

    rand bit [7:0]ui_in;
    rand bit [7:0]uio_in;
    ///////////////output 
    bit [7:0]uo_out;
    bit [7:0]uio_out;
    bit [7:0]uio_oe;

    function void post_randomize();
        uvm_config_db#(longint)::get(this,"","count",needed_count);
        if(count==needed_count)
            count=0;
        else
            count++;
    endfunction

endclass
