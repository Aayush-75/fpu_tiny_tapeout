class my_sequence extends uvm_sequence#(seq_item);

    static longint needed_count;

    `uvm_object_utils(my_sequence)

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
        needed_count=0;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 0;
        };
        finish_item(req);
    endtask

endclass
/*
class normal_addition extends my_sequence;

    `uvm_object_utils(normal_addition)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=15;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
           // rst_n ==1 ;
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
            if((count==12) || (count==14))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            //start
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==9)
            {
                ui_in[3] == 0;
            }

            if (count==14)
              {
                 rst_n ==0;
              }
            else
              {
                rst_n ==1 ;
              }

            if (count==1)
                  uio_in ==8'b00000000;
            if (count ==3)
                 uio_in == 8'b01000100;                 //8'h44 & 8'h00 (0_10001_0000000000)
            if (count ==5)
                 uio_in == 8'b00000000;
            if (count ==7)
                 uio_in ==8'b01000101;//  8'h45 & 8'h00 (0_10001_0100000000),
        };
        finish_item(req);
    endtask

endclass
*/
class normal_addition extends my_sequence;

    `uvm_object_utils(normal_addition)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=14;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 1;
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
            if((count==12) || (count==14))
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
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            /*
            if(count==8)
            {
                ui_in[3] == 0;
            }
            else
            {
                ui_in[3] == 1;
            }
            */
            //eact values
            /*
            if((count==1))
            {
                uio_in == 8'h00;
            }
            else if((count==3))
            {
                uio_in == 8'h44;
            }
            else if((count==5))
            {
                uio_in == 8'h00;
            }
            else if((count==7))
            {
                uio_in == 8'h45;
            }
            */
        };
        finish_item(req);
    endtask

endclass

class write_busy extends my_sequence;

    `uvm_object_utils(write_busy)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=48;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 1;
            if((count==0) || (count==2) || (count==4) || (count==6) || (count==13) || (count==15))
            {
                ui_in[0] == 1;
            }
            else
            {
                ui_in[0] == 0;
            }
            if((count==24) || (count==26) || (count==44) || (count==46))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            if((count==12) || (count==32))
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            ui_in[3] == 0;
            ui_in[7:4] == 4'b0000;


            if (count==1)
                uio_in == 8'b00000000;
            if (count==3)
                uio_in == 8'b01000100;   // 8'h44


            if (count==5)
                uio_in == 8'b00000000;
            if (count==7)
                uio_in == 8'b01000101;   // 8'h45


            if (count==14)
                uio_in == 8'b00000001;
            if (count==16)
                uio_in == 8'b00111100;   // 8'h3C
        };
        finish_item(req);
    endtask

endclass
