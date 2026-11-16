class scorboard extends uvm_scorebaord;

    `uvm_component_utils(scoreboard)

    function new(string name="", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    uvm_tlm_analysis_fifo#(seq_item) ip_fifo;
    uvm_tlm_analysis_fifo#(seq_item) op_fifo;

    seq_item ip;
    seq_item op;

    bit p_write_en;
    bit p_read_en;
    bit p_start;
    bit p_busy;

    biy operation_complete;

    bit [15:0]a;
    bit [15:0]b;
    bit [15:0]result;

    real opa;
    real opb;
    real real_result

    bit [1:0]write_ptr;
    bit read_ptr;

    int busy_cnt;

    int PASS,FAIL;

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
        if(ip.rst_n==0)
        begin
            uo_out = 0;
            uio_out = 0;
            uio_oe = 0;
            p_write_en = 0;
            p_read_en = 0;
            p_start = 0;
        end
        else
        begin
            ip.uo_out[7:4] = {2'b0,write_ptr};
            if(p_busy==1)
            begin
                ip.uo_out[0] = 1;
                busy_cnt++;
                if(a[14:0]==0)
                begin
                    if(busy_cnt==2)
                    begin
                        ip.ui_out[0] = 0;
                        ip.ui_out[1] = 1;
                        ip.ui_out[2] = 0;
                        p_busy = 0;
                        operation_complete = 1;
                        result = b;
                    end
                end
                else if(b[14:0]==0)
                begin
                    if(busy_cnt==2)
                    begin
                        ip.ui_out[0] = 0;
                        ip.ui_out[1] = 1;
                        ip.ui_out[2] = 0;
                        p_busy = 0;
                        operation_complete = 1;
                        result = a;
                    end
                end
                else if((a[14:10]==0) && (a[14:10]==31) && (b[14:10]==0) && (b[14:10]==31))
                begin
                    if(busy_cnt==2)
                    begin
                        ip.ui_out[0] = 0;
                        ip.ui_out[1] = 1;
                        ip.ui_out[2] = 1;
                        p_busy = 0;
                        operation_complete = 1;
                        result = 0;
                    end
                end
                else
                begin
                    if(busy_cnt==3)
                    begin
                        ip.ui_out[0] = 0;
                        ip.ui_out[1] = 1;
                        ip.ui_out[2] = 1;
                        p_busy = 0;
                        operation_complete = 1;
                        if(a[15]==1'b0)
                        begin
                            opa = ((2.0**(a[14:10]-15))*((1.0)+(a[9]/2.0)+(a[8]/4.0)+(a[7]/8.0)+(a[6]/16.0)+(a[5]/32.0)+(a[4]/64.0)+(a[3]/128.0)+(a[2]/256.0)+(a[1]/512.0)+(a[0]/1024.0)));
                        end
                        else if(a[15]==1'b1)
                        begin
                            opa = -((2.0**(a[14:10]-15))*((1.0)+(a[9]/2.0)+(a[8]/4.0)+(a[7]/8.0)+(a[6]/16.0)+(a[5]/32.0)+(a[4]/64.0)+(a[3]/128.0)+(a[2]/256.0)+(a[1]/512.0)+(a[0]/1024.0)));
                        end
                        if(b[15]==1'b0)
                        begin
                            opb = ((2.0**(b[14:10]-15))*((1.0)+(b[9]/2.0)+(b[8]/4.0)+(b[7]/8.0)+(b[6]/16.0)+(b[5]/32.0)+(b[4]/64.0)+(b[3]/128.0)+(b[2]/256.0)+(b[1]/512.0)+(b[0]/1024.0)));
                        end
                        else if(b[15]==1'b1)
                        begin
                            opb = ((2.0**(b[14:10]-15))*((1.0)+(b[9]/2.0)+(b[8]/4.0)+(b[7]/8.0)+(b[6]/16.0)+(b[5]/32.0)+(b[4]/64.0)+(b[3]/128.0)+(b[2]/256.0)+(b[1]/512.0)+(b[0]/1024.0)));
                        end
                        if(ip.ui_in[3]==0)
                        begin
                            real_result = opa + opb;
                        end
                        else
                        begin
                            real_result = opa - opb;
                        end
                        result = real_to_fp16(real_result);
                    end
                end
            end
            if((p_write_en==0) && (ip.ui_in[0]==1) && (ip.uo_out[0]==0) && (!operation_complete))
            begin
                case(write_ptr)
                    0: a[7:0] = uio_in;
                    1: a[15:8] = uio_in;
                    2: b[7:0] = uio_in;
                    3: b[15:8] = uio_in;
                endcase
                if(write_ptr==3)
                begin
                    ip.uo_out[3] = 1'b1;
                end
                else
                begin
                    ip.uo_out[3] = 1'b0;
                end
                write_ptr++;
            end
            else if((p_read_en==0) && (ip.ui_in[1]==1) && (ip.uo_out==0))
            begin
                case(read_ptr)
                    0: ip.uio_out = result[7:0];
                    1: ip.uio_out = result[15:8];
                endcase
            end 
            if((p_start==0) && (ip.ui_in[2]==1) && (ip.uo_out[3]==1) && (ip.uo_out[0]==0) && (!operation_complete))
            begin
                p_busy=1;
            end
        end
        p_write_en = ip.ui_in[0];
        p_read_en = ip.ui_in[1];
        p_start = ip.ui_in[2];
        operation_complete = 0;
    endtask

    task checkk();
        if((ip.uo_out==op.uo_out) && (op.uio_out==ip.uio_out))
    endtask

    function automatic logic [15:0] real_to_fp16(real val);
    logic [63:0] fp64_bits;
    logic        sign;
    logic [10:0] exp64;
    logic [51:0] frac64;
    
    logic [4:0]  exp16;
    logic [9:0]  frac16;
    int          true_exp;

    //Convert real to 64-bit vector
    fp64_bits = $realtobits(val);
    
    sign   = fp64_bits[63];
    exp64  = fp64_bits[62:52];
    frac64 = fp64_bits[51:0];
    
    //Calculate true mathematical exponent
    true_exp = int'(exp64) - 1023; 

    //Handle conversion, overflow, and underflow
    if (exp64 == 11'h000) begin
        //Exact Zero (Flushing subnormals to zero for simplicity)
        exp16  = 5'h00;
        frac16 = 10'h000;
    end 
    else if (exp64 == 11'h7FF) begin
        //Infinity or NaN
        exp16  = 5'h1F;
        frac16 = (frac64 == '0) ? 10'h000 : {1'b1, 9'd0}; // Infinity or Quiet NaN
    end 
    else if (true_exp > 15) begin
        //Overflow (Number is too large for FP16, clamp to Infinity)
        exp16  = 5'h1F;
        frac16 = 10'h000;
    end 
    else if (true_exp < -14) begin
        //Underflow (Number is too small for FP16 normal, clamp to Zero)
        exp16  = 5'h00;
        frac16 = 10'h000;
    end 
    else begin
        //Standard Normalized Number
        //Apply FP16 bias (15) to the true exponent
        exp16  = 5'(true_exp + 15);
        
        //Truncate the 52-bit fraction down to 10 bits
        frac16 = frac64[51:42]; 
    end
    return {sign, exp16, frac16};
endfunction

endclass
