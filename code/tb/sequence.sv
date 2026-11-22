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

class normal_addition extends my_sequence;

    `uvm_object_utils(normal_addition)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=16;
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
            if((count==14) || (count==16) )// || (count == 18) || (count == 22))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            //start
            if(count==10)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==11)
                ui_in[3] == 0;
              /*
               if (count==1)
                    uio_in ==8'b00000000;

                if (count ==3)
                   uio_in == 8'b01000100;                 //8'h44 & 8'h00 (0_10001_0000000000)
                 if (count ==5)
                   uio_in == 8'b00000000;
                  if (count ==7)
                    uio_in ==8'b01000101;//  8'h45 & 8'h00 (0_10001_0100000000),
                  */

        };
        finish_item(req);
    endtask

endclass

///////////////////////

class normal_subtraction extends my_sequence;

    `uvm_object_utils(normal_subtraction)

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
            if((count==13) || (count==15))
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
                ui_in[3] == 1;
            }
             /*if (count==1)
                uio_in ==8'b00000000;
            if (count ==3)
                uio_in == 8'b01000100;                 //8'h44 & 8'h00 (0_10001_0000000000)
            if (count ==5)
                uio_in == 8'b00000000;
            if (count ==7)
                uio_in ==8'b01000101;//  8'h45 & 8'h00 (0_10001_0100000000),*/
        };
        finish_item(req);
    endtask

endclass


class normal_inf extends my_sequence;

    `uvm_object_utils(normal_inf)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }

        };
        finish_item(req);
    endtask

endclass


class normal_overflow extends my_sequence;

    `uvm_object_utils(normal_overflow)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==8)
            {
                ui_in[3] == 0;
            }

             if (count==1)
                    uio_in ==8'b11111111;
             if (count ==3)
                   uio_in == 8'b01111011;    // 8'h7B &&8'hFF ( 0_11110_1111111111)
             if (count ==5)
                   uio_in == 8'b11111110;
             if (count ==7)
                    uio_in ==8'b01111011;//   8'h7B &8'hFE (0_11110_1111111110)
        };
        finish_item(req);
    endtask

endclass


class normal_underflow extends my_sequence;

    `uvm_object_utils(normal_underflow)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==8)
            {
                ui_in[3] == 1;
            }
            if (count==1)
                 uio_in ==8'b00000000;
            if (count ==3)
                uio_in == 8'b00001000;    // 8'h08 & 8'h00 (0_00010_0000000000),
            if (count ==5)
                uio_in == 8'b11111111;
            if (count ==7)
                 uio_in ==8'b00000111;//    8'h07 & 8'hFF (0_00001_1111111111)
        };
        finish_item(req);
    endtask

endclass

class normal_zero extends my_sequence;

    `uvm_object_utils(normal_zero)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==8)
            {
                ui_in[3] == 0;
            }
            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b00000000;    // 8'h00 & 8'h00
            if (count ==5)
                   uio_in == 8'b00000000;
            if (count ==7)
                    uio_in ==8'b00000000;//    8'h00 & 8'h00
        };
        finish_item(req);
    endtask

endclass


class write_en_high extends my_sequence;

    `uvm_object_utils(write_en_high)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=16;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 1;
            //write_en
            if((count==0) || (count==1) || (count==2) || (count==4) || (count==6) || (count ==8))
            {
                ui_in[0] == 1;

            }

            else
            {
                ui_in[0] == 0;
            }
            //read_en
            if((count==14) || (count==16))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            //start
            if(count==10)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==11)
            {
                ui_in[3] == 0;
            }

             if (count==1)
                   uio_in ==8'b00000000;       // 8'h00
             if (count ==5)
                   uio_in == 8'b00111110;    // 8'h3E
             if (count ==7)
                   uio_in == 8'b10000000;  // 8'h80
             if (count ==9)
                   uio_in ==8'b01000000;//    8'h40
        };
        finish_item(req);
    endtask

endclass


class normal_NAN extends my_sequence;

    `uvm_object_utils(normal_NAN)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==8)
            {
                ui_in[3] == 0;
            }
            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b01111110;  // 8'h7E &&8'h00 ( 0_11111_1000000000) ,
            if (count ==5)
                   uio_in == 8'b00000000;
            if (count ==7)
                    uio_in ==8'b00111100;//    uio_in = 8'h3c &8'h00 (0_01111_0000000000)
        };
        finish_item(req);
    endtask

endclass



class reset_in_between extends my_sequence;

    `uvm_object_utils(reset_in_between)

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





class subnormal extends my_sequence;

    `uvm_object_utils(subnormal)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==8)
            {
                ui_in[3] == 0;
            }
            if (count==1)
                    uio_in ==8'b00010000;
            if (count ==3)
                   uio_in == 8'b00000000;  // uio_in =16'h 10 ( 0_00000_0000010000)
            if (count ==5)
                   uio_in == 8'b00100000;
            if (count ==7)
                    uio_in ==8'b00000000;//   16'h20 (0_00000_0000100000)
        };
        finish_item(req);
    endtask

endclass

class operand1_zero extends my_sequence;

    `uvm_object_utils(operand1_zero)

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
                ui_in[3] == 1;
            }
            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b00000000;  // uio_in =16'h 00 ( 0_00000_0000010000)
            if (count ==5)
                   uio_in == 8'b00000000;
            if (count ==7)
                    uio_in ==8'b01000010;// =8'h42 && 8'h00 (0_10000_100000000)
        };
        finish_item(req);
    endtask

endclass


class operand2_zero extends my_sequence;

    `uvm_object_utils(operand2_zero)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==8)
            {
                ui_in[3] == 0;
            }
            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                  uio_in == 8'b01000010;// =8'h42 && 8'h00 (0_10000_100000000)
            if (count ==5)
                   uio_in == 8'b00000000;
            if (count ==7)
                    uio_in ==8'b00000000;//   16'h00 (0_00000_0000100000)
        };
        finish_item(req);
    endtask

endclass


class signed_addition extends my_sequence;

    `uvm_object_utils(signed_addition)

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
            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==8)
            {
                ui_in[3] == 0;
            }
            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b10111110;  // uio_in = 8'hBE &&8'h00 ( 1_01111_1000000000)
            if (count ==5)
                   uio_in == 8'b00000000;

            if (count ==7)
                   uio_in ==8'b11000000;//   uio_in = 8'hC0 &8'h00 (1_10000_0000000000)

        };
        finish_item(req);
    endtask

endclass

class addition_8_write extends my_sequence;

    `uvm_object_utils(addition_8_write)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=22;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 1;
            //write_en
            if((count==0) || (count==2) || (count==4) || (count==6) ||(count==8) || (count==10) || (count==12) || (count==14))
            {
                ui_in[0] == 1;

            }
            else
            {
                ui_in[0] == 0;
            }
            //read_en
            if((count==20) || (count==22))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            //start
            if(count==16)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if(count==16)
            {
                ui_in[3] == 0;
            }
            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b01000010;  // uio_in =8'h42 && 8'h00 (0_10000_100000000)
             if (count ==5)
                   uio_in == 8'b00000000;
            if (count ==7)
                    uio_in ==8'b01000100;//   uio_in = 8'h44 &&8'h00 (0_10001_0000000000)

             if (count==9)
                    uio_in ==8'b00000000;
            if (count ==11)
                   uio_in == 8'b00111000;  // uio_in = 8'h38 &&8'h00 (0_01110_0000000000)
             if (count ==13)
                   uio_in == 8'b00000000;
            if (count ==15)
                    uio_in ==8'b00111100;//   uio_in =8'h3c && 8'h00 (0_01111_00000000)

        };
        finish_item(req);
    endtask

endclass

class read_delay extends my_sequence;

    `uvm_object_utils(read_delay)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=16;
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
            if((count==14) || (count==16))
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
            if(count==8)
            {
                ui_in[3] == 0;
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

class ena_toggle extends my_sequence;

    `uvm_object_utils(ena_toggle)

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
            rst_n == 1;
            ena == 0;
             ui_in[3] == 0;
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

            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b10111110;  // uio_in = 8'hBE &&8'h00 ( 1_01111_1000000000)
            if (count ==5)
                   uio_in == 8'b00000000;

            if (count ==7)
                   uio_in ==8'b11000000;//   uio_in = 8'hC0 &8'h00 (1_10000_0000000000)

        };
        finish_item(req);
    endtask

endclass


class read_only extends my_sequence;

    `uvm_object_utils(read_only)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=2;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 1;

            //read_en
            if((count==0) || (count==2))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }


        };
        finish_item(req);
    endtask

endclass



class write_read_11 extends my_sequence;

    `uvm_object_utils(write_read_11)

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
            rst_n == 1;
             ui_in[3] == 0;
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
            if((count==0) || (count==2) || (count ==12 ) || (count ==14))
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

class normalization extends my_sequence;

    `uvm_object_utils(normalization)

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
             ui_in[3] == 0;

            if((count==0) || (count==2) || (count==4) || (count==6))
            {
                ui_in[0] == 1;

            }
            else
            {
                ui_in[0] == 0;
            }

            if((count==12) || (count==14))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }

            if(count==8)
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }


            if (count==1)
                  uio_in ==8'b00000000;
            if (count ==3)
                  uio_in == 8'b00111100;   // 16'h3C00 (0_01111_0000000000)
            if (count ==5)
                  uio_in == 8'b00000000;
            if (count ==7)
                  uio_in == 8'b10111000;// 16'hB800 ( 1_01110_0000000000)

        };
        finish_item(req);
    endtask

endclass

/*
class write_busy extends my_sequence;

    `uvm_object_utils(write_busy)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=19;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 1;
            //write_en
            if((count==0) || (count==2) || (count==4) || (count==6) || (count ==9) || (count ==11) || (count ==13) || (count == 15))
            {
                ui_in[0] == 1;

            }
            else
            {
                ui_in[0] == 0;
            }
            //read_en
            if((count==17) || (count==19))
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

            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b01000100;                 //8'h44 & 8'h00 (0_10001_0000000000)
             if (count ==5)
                   uio_in == 8'b00000000;
            if (count ==7)
                    uio_in ==8'b01000101;//  8'h45 & 8'h00 (0_10001_0100000000),

              if (count==10)
                  uio_in ==8'b00000000;
            if (count ==12)
                  uio_in == 8'b00111100;   // 16'h3C00 (0_01111_0000000000)
            if (count ==14)
                  uio_in == 8'b00000000;
            if (count ==16)
                  uio_in == 8'b10111000;// 16'hB800 ( 1_01110_0000000000)

        };
        finish_item(req);
    endtask

endclass
*/

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

class error_recover extends my_sequence;

    `uvm_object_utils(error_recover)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=32;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
          //  rst_n == 1;
            //write_en
            if((count==0) || (count==2) || (count==4) || (count==6) || (count ==18) || (count ==20) || (count ==22) || (count ==24))
            {
                ui_in[0] == 1;

            }
            else
            {
                ui_in[0] == 0;
            }
            //read_en
            if((count==12) || (count==14)  || (count ==30) || (count == 32))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            //start
            if((count==8) || (count ==26))
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }
            //opcode
            if((count==9) || (count ==27 ))
            {
                ui_in[3] == 0;
            }

            if (count ==17)
             {
                rst_n == 0;
             }
            else
             {
                rst_n == 1 ;
              }


            if (count==1)
                    uio_in ==8'b00000000;
            if (count ==3)
                   uio_in == 8'b01111110;  // 8'h7E &&8'h00 ( 0_11111_1000000000) ,
            if (count ==5)
                   uio_in == 8'b00000000;
            if (count ==7)
                    uio_in ==8'b00111100;//    uio_in = 8'h3c &8'h00 (0_01111_0000000000)

            if (count==19)
                    uio_in ==8'b00000000;
            if (count ==21)
                   uio_in == 8'b01000100;                 //8'h44 & 8'h00 (0_10001_0000000000)
             if (count ==23)
                   uio_in == 8'b00000000;
            if (count ==25)
                    uio_in ==8'b01000101;//  8'h45 & 8'h00 (0_10001_0100000000),


        };
        finish_item(req);
    endtask

endclass



//////////////////








/////////////////


class start_pulse extends my_sequence;

    `uvm_object_utils(start_pulse)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count = 24;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);

        req = seq_item::type_id::create("seq");
        start_item(req);

        req.randomize() with
        {
            rst_n == 1;
            ui_in[3] ==0;
            // write_en
            if((count==0) || (count==2) || (count==4) || (count==6))
                ui_in[0] == 1;
            else
                ui_in[0] == 0;

            // read_en
            if((count==12) || (count==14) ||
               (count==24) || (count==22) || (count == 18))
                ui_in[1] == 1;
            else
                ui_in[1] == 0;


            if((count==8) || (count==17))
                ui_in[2] == 1;
            else
                ui_in[2] == 0;


          //  if(count==9)
             //   ui_in[3] == 0;


            if(count==1)
                uio_in == 8'b00000000;
            if(count==3)
                uio_in == 8'b01000100;


            if(count==5)
                uio_in == 8'b00000000;
            if(count==7)
                uio_in == 8'b01000101;
        };

        finish_item(req);
    endtask

endclass




class multiple_addition extends my_sequence;

    `uvm_object_utils(multiple_addition)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count = 35;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);

        req = seq_item::type_id::create("seq");
        start_item(req);

        req.randomize() with
        {
            rst_n == 1;
            ui_in [3] == 0;

            if((count==0) || (count==2) || (count==4) || (count==6) ||(count==18) || (count==20) || (count==22) || (count==24))
                ui_in[0] == 1;
            else
                ui_in[0] == 0;

            if((count==14) || (count==16) || (count==34) || (count==32))
                ui_in[1] == 1;
            else
                ui_in[1] == 0;


            if((count==10) || (count==28))
                ui_in[2] == 1;
            else
                ui_in[2] == 0;





            if(count==1)
                uio_in == 8'h00;
            if(count==3)
                uio_in == 8'h44;


            if(count==5)
                uio_in == 8'h00;
            if(count==7)
                uio_in == 8'h45;

          if(count==19)
              uio_in == 8'h00;
           if(count==21)
              uio_in == 8'h3E;

           if(count==23)
             uio_in == 8'h80;
           if(count==25)
              uio_in == 8'h40;
        };

        finish_item(req);
    endtask

endclass



class add_sub extends my_sequence;

    `uvm_object_utils(add_sub)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count = 35;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);

        req = seq_item::type_id::create("seq");
        start_item(req);

        req.randomize() with
        {
            rst_n == 1;


            if((count==0) || (count==2) || (count==4) || (count==6) || (count==18) || (count==20) || (count==22) || (count==24))
                ui_in[0] == 1;
            else
                ui_in[0] == 0;


            if((count==14) || (count==16) ||(count==30) || (count==32) || (count ==34))
                ui_in[1] == 1;
            else
                ui_in[1] == 0;


            if((count==10) || (count==28))
                ui_in[2] == 1;
            else
                ui_in[2] == 0;


            if(count==11)
                ui_in[3] == 0;
            else if(count==29)
                ui_in[3] == 1;
            else
                ui_in[3] == 0;


            if(count==1)
                uio_in == 8'h00;
            if(count==3)
                uio_in == 8'h44;

            if(count==5)
                uio_in == 8'h00;
            if(count==7)
                uio_in == 8'h45;


            if(count==19)
                uio_in == 8'h00;
            if(count==21)
                uio_in == 8'h3E;

            if(count==23)
                uio_in == 8'h80;
            if(count==25)
                uio_in == 8'h40;
        };

        finish_item(req);
    endtask

endclass

class read_busy extends my_sequence;

    `uvm_object_utils(read_busy)

    function new(string name="");
        super.new(name);
    endfunction

    task body();
        needed_count=19;
        uvm_config_db#(longint)::set(null,"*","count",needed_count);
        req = seq_item::type_id::create("seq");
        start_item(req);
        req.randomize() with
        {
            rst_n == 1;
            if((count==0) || (count==2) || (count==4) || (count==6))
            {
                ui_in[0] == 1;
            }
            else
            {
                ui_in[0] == 0;
            }
            if((count==13) || (count==15) || (count==17) || (count==19))
            {
                ui_in[1] == 1;
            }
            else
            {
                ui_in[1] == 0;
            }
            if((count==12))
            {
                ui_in[2] == 1;
            }
            else
            {
                ui_in[2] == 0;
            }


        };
        finish_item(req);
    endtask

endclass


class write_read_busy extends my_sequence;

    `uvm_object_utils(write_read_busy)

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
            if((count==13) || (count==15) || (count==24) || (count==26) || (count==44) || (count==46))
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


        };
        finish_item(req);
    endtask

endclass
