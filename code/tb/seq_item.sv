class seq_item extends uvm_seq_item;

    `uvm_object_utils(seq_item)

    function new(string name="");
        super.new(name);
    endfunction 

    /////////////input 
    rand bit rst_n;
    rand bit ena;

    rand bit [7:0]ui_in;
    rand bit [7:0]uio_in;
    ///////////////output 
    bit [7:0]uo_out;
    bit [7:0]uio_out;
    bit [7:0]uio_oe;

endclass
