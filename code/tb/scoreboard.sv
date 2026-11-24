class scoreboard extends uvm_scoreboard;

    `uvm_component_utils(scoreboard)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    uvm_tlm_analysis_fifo#(seq_item) ip_fifo;
    uvm_tlm_analysis_fifo#(seq_item) op_fifo;

    seq_item ip;
    seq_item op;
    seq_item refv;

    bit p_write_en;
    bit p_read_en;
    bit p_start;
    bit p_busy;
    bit p_write_operand;

    bit operation_complete;
    bit sign;
    bit store_now;

    bit [15:0]a;
    bit [15:0]b;
    bit [15:0]result;

    bit [11:0]tmp_result;
    bit [10:0]ma,mb;

    int ea,eb,eres,lead_zero;
    bit [4:0]ediff;
    bit res_sign;

    bit [1:0]write_ptr;
    bit read_ptr;

    int busy_cnt;

    int PASS,FAIL;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ip_fifo = new("input fifo",this);
        op_fifo = new("output fifo",this);
        refv = seq_item::type_id::create("ref var for scb");
    endfunction

    task run_phase(uvm_phase phase);
        forever
        begin
            ip_fifo.get(ip);
            op_fifo.get(op);
            `uvm_info(get_type_name(),$sformatf("[%0t]INPUT: rst_n = %0b ui_in[3:0] = %0b uio_in = %0b %0h",$time,ip.rst_n,ip.ui_in[3:0],ip.uio_in,ip.uio_in),UVM_NONE)
            ref_task();
            chekk();
            $display("");
            $display("");
        end
    endtask

    task ref_task();
        if(ip.rst_n==0)
        begin
            // ip.uo_out = 0;
            // ip.uio_out = 0;
            // ip.uio_oe = 0;
            refv.uo_out = 0;
            refv.uio_out = 0;
            refv.uio_oe = 0;
            p_write_en = 0;
            p_read_en = 0;
            p_start = 0;
            p_busy = 0;
            p_write_operand = 0;
            result = 0;
            a = 0;
            b = 0;
            operation_complete = 0;
            sign = 0;
            store_now=0;
            read_ptr = 0;
            write_ptr = 0;
        end
        else
        begin
            if((p_read_en==1) && p_write_operand==0) && p_busy==0)
            begin
                // ip.uio_oe = 8'hFF;
                refv.uio_oe = 8'hFF;
            end
            else
            begin
                // ip.uio_oe = 8'h00;
                refv.uio_oe = 8'h00;
            end
            if(p_write_operand==1)
            begin
                 case(write_ptr)
                    0: a[7:0] = ip.uio_in;
                    1: a[15:8] = ip.uio_in;
                    2: b[7:0] = ip.uio_in;
                    3: b[15:8] = ip.uio_in;
                 endcase
                 //$display("a is %0h %0b",a,a);
                 //$display("b is %0h %0b",b,b);
                 p_write_operand=0;
                 if((write_ptr)==3)
                 begin
                     // ip.uo_out[3] = 1'b1;
                     refv.uo_out[3] = 1'b1;
                 end
                 else
                begin
                     // ip.uo_out[3] = 1'b0;
                      refv.uo_out[3] = 1'b0;
                end
                write_ptr++;
            end
            // ip.uo_out[7:4] = {2'b0,write_ptr};
            refv.uo_out[7:4] = {2'b0,write_ptr};
            if(p_busy==1)
            begin
                if(store_now==1)
                begin
                    read_ptr=0;
                    sign = ip.ui_in[3];
                    store_now = 0;
                end
                //$display("storing value of sign %0b",sign);
                // ip.uo_out[0] = 1;
                refv.uo_out[1] = 0;
                refv.uo_out[2] = 0;
                refv.uo_out[0] = 1;
                busy_cnt++;
                if(b[14:0]==0)
                begin
                    if(busy_cnt==3)
                    begin
                        // ip.uo_out[0] = 0;
                        // ip.uo_out[1] = 1;
                        // ip.uo_out[2] = 0;
                        refv.uo_out[0] = 0;
                        refv.uo_out[1] = 1;
                        refv.uo_out[2] = 0;
                        p_busy = 0;
                        operation_complete = 1;
                        result = {sign,a[14:0]};
                        busy_cnt=0;
                        $display("3 operated on a:%0b %0h |  b:%0b %0h",a,a,b,b);
                    end
                end
                else if(a[14:0]==0)
                begin
                    if(busy_cnt==3)
                    begin
                        // ip.uo_out[0] = 0;
                        // ip.uo_out[1] = 1;
                        // ip.uo_out[2] = 0;
                        refv.uo_out[0] = 0;
                        refv.uo_out[1] = 1;
                        refv.uo_out[2] = 0;
                        p_busy = 0;
                        operation_complete = 1;
                        result = {sign,b[14:0]};
                        busy_cnt=0;
                        $display("3 operated on a:%0b %0h |  b:%0b %0h",a,a,b,b);
                    end
                end
                else if((a[14:10]==0) || (a[14:10]==31) || (b[14:10]==0) || (b[14:10]==31))
                begin
                    if(busy_cnt==3)
                    begin
                        // ip.uo_out[0] = 0;
                        // ip.uo_out[1] = 1;
                        // ip.uo_out[2] = 1;
                        refv.uo_out[0] = 0;
                        refv.uo_out[1] = 1;
                        refv.uo_out[2] = 1;
                        p_busy = 0;
                        operation_complete = 1;
                        result = 0;
                        busy_cnt=0;
                        $display("3 operated on a:%0b %0h |  b:%0b %0h",a,a,b,b);
                    end
                end
                else
                begin
                    if(busy_cnt==4)
                    begin
                        // ip.uo_out[0] = 0;
                        // ip.uo_out[1] = 1;
                        // ip.uo_out[2] = 0;
                        refv.uo_out[0] = 0;
                        refv.uo_out[1] = 1;
                        refv.uo_out[2] = 0;
                        p_busy = 0;
                        operation_complete = 1;
                        ea = a[14:10];
                        eb = b[14:10];
                        ma = {1'b1,a[9:0]};
                        mb = {1'b1,b[9:0]};
                        ediff = (ea>eb)?(ea-eb):(eb-ea);
                        if(ea>eb)
                        begin
                            mb = mb>>ediff;
                            eres = ea;
                            res_sign = a[15];
                            if(sign==0)
                            begin
                                if(a[15]==b[15])
                                begin
                                    tmp_result = mb+ma;
                                end
                                else
                                begin
                                    tmp_result = ma-mb;
                                end
                            end
                            else //means subtarction
                            begin
                                if(a[15]==b[15])
                                begin
                                    tmp_result = ma-mb;
                                end
                                else
                                begin
                                    tmp_result = mb+ma;
                                end
                            end
                            if (tmp_result[11] == 1)
                            begin
                                tmp_result = tmp_result >> 1;
                                eres = eres + 1;
                                result = (eres >= 31) ? {res_sign, 5'h1F, 10'd0} : {res_sign, eres[4:0], tmp_result[9:0]};
                            end
                            else
                            begin
                                lead_zero = 0;
                                while ((tmp_result[10] != 1) && (lead_zero != 10))
                                begin
                                    tmp_result = tmp_result << 1;
                                    lead_zero++;
                                end
                                eres = eres - lead_zero;
                                if (eres > 0)
                                    result = {res_sign, eres[4:0], tmp_result[9:0]};
                                else
                                    result = {res_sign,15'b0};
                            end
                        end
                        else if (eb > ea)
                        begin
                            ma = ma >> ediff;
                            eres = eb;
                            res_sign = b[15] ^ sign;

                            if (sign == 0)
                            begin
                                if (a[15] == b[15])
                                    tmp_result = ma + mb;
                                else
                                    tmp_result = mb - ma;
                            end
                            else
                            begin
                                if (a[15] == b[15])
                                    tmp_result = mb - ma;
                                else
                                    tmp_result = ma + mb;
                            end
                            if (tmp_result[11] == 1)
                            begin
                                tmp_result = tmp_result >> 1;
                                eres = eres + 1;
                                result = (eres >= 31) ? {res_sign, 5'h1F, 10'd0} : {res_sign, eres[4:0], tmp_result[9:0]};
                            end
                            else
                            begin
                                lead_zero = 0;
                                while (tmp_result[10] != 1 && (lead_zero != 10))
                                begin
                                    tmp_result = tmp_result << 1;
                                    lead_zero++;
                                end
                                eres = eres - lead_zero;
                                if (eres > 0)
                                    result = {res_sign, eres[4:0], tmp_result[9:0]};
                                else
                                    result = {res_sign,15'b0};
                            end
                        end
                        else
                        begin
                            eres = ea;
                            if ((sign == 0 && a[15] == b[15]) || (sign == 1 && a[15] != b[15]))
                            begin
                                tmp_result = ma + mb;
                                res_sign = a[15];
                            end
                            else
                            begin
                                if (ma >= mb)
                                begin
                                    tmp_result = ma - mb;
                                    res_sign = a[15];
                                end
                                else
                                begin
                                    tmp_result = mb - ma;
                                    res_sign = b[15] ^ sign;
                                end
                            end
                            if (tmp_result == 0)
                                result = 0;
                            else if (tmp_result[11] == 1)
                            begin
                                tmp_result = tmp_result >> 1;
                                eres = eres + 1;
                                result = (eres >= 31) ? {res_sign, 5'h1F, 10'd0} : {res_sign, eres[4:0], tmp_result[9:0]};
                            end
                            else
                            begin
                                lead_zero = 0;
                                while (tmp_result[10] != 1 && (lead_zero != 10))
                                begin
                                    tmp_result = tmp_result << 1;
                                    lead_zero++;
                                end
                                eres = eres - lead_zero;
                                if (eres > 0)
                                    result = {res_sign, eres[4:0], tmp_result[9:0]};
                                else
                                    result = {res_sign,15'b0};
                            end
                        end
                        busy_cnt=0;
                        $display("4 operated on a:%0b %0h |  b:%0b %0h",a,a,b,b);
                    end
                end
            end
            //if(refv.uo_out[0]==0)
            //begin
                case(read_ptr)
                    0: begin
                        // ip.uio_out = result[7:0];
                        refv.uio_out = result[7:0];
                    end
                    1: begin
                        // ip.uio_out = result[15:8];
                        refv.uio_out = result[15:8];
                    end
                endcase
            //end
            `uvm_info(get_type_name(),$sformatf("p_start = %0b start = %0b ready = %0b busy = %0b",p_start,ip.ui_in[2],refv.uo_out[3],refv.uo_out[0]),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("p_wr_en = %0b w_en = %0b busy = %0b",p_write_en,ip.ui_in[0],refv.uo_out[0]),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("p_rd_en = %0b rd_en = %0b busy = %0b",p_read_en,ip.ui_in[1],refv.uo_out[0]),UVM_NONE)


            if((p_start==0) && (ip.ui_in[2]==1) && (refv.uo_out[3]==1) && (refv.uo_out[0]==0))
            begin
                p_busy = 1;
                //$display("got sign and on next cycle I ll store sign %0b",sign);
                store_now = 1;
            end
            else if((p_write_en==0) && (ip.ui_in[0]==1) && (refv.uo_out[0]==0))
            begin
                p_write_operand = 1;
            end
            else if((p_read_en==1) && (ip.ui_in[1]==0) && (refv.uo_out[0]==0))
            begin
                read_ptr++;
            end

          p_write_en = ip.ui_in[0];
          p_read_en = ip.ui_in[1];
          p_start = ip.ui_in[2];
          operation_complete = 0;
        end
    endtask

    task chekk();
        if((refv.uo_out==op.uo_out) && (refv.uio_out==op.uio_out) && (refv.uio_oe==op.uio_oe))
        begin
            PASS++;
            `uvm_info(get_type_name(),$sformatf("[%0t]-----------------PASS-------------------",$time),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("PASS = %0d",PASS),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("DUT: op.uo_out = %0b | op.uio_out = %0b | op.uio_oe = %0b",op.uo_out,op.uio_out,op.uio_oe),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("REF: refv.uo_out = %0b | refv.uio_out = %0b | refv.uio_oe = %0b",refv.uo_out,refv.uio_out,refv.uio_oe),UVM_NONE)
        end
        else
        begin
            FAIL++;
            `uvm_info(get_type_name(),$sformatf("[%0t]-----------------FAIL-------------------",$time),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("FAIL = %0d",FAIL),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("DUT: op.uo_out = %0b | op.uio_out = %0b | op.uio_oe = %0b",op.uo_out,op.uio_out,op.uio_oe),UVM_NONE)
            `uvm_info(get_type_name(),$sformatf("REF: refv.uo_out = %0b | refv.uio_out = %0b | refv.uio_oe = %0b",refv.uo_out,refv.uio_out,refv.uio_oe),UVM_NONE)
        end
    endtask

endclass
