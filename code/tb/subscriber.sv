class fpu_subscriber extends uvm_subscriber # (seq_item);
 `uvm_component_utils (fpu_subscriber)

  seq_item sub;


  covergroup cg ;
    //input coverage
    a:coverpoint sub.rst_n {bins rst[]= {0,1};}
    b:coverpoint sub.ena {bins enable [] ={0,1};}
    c:coverpoint sub.ui_in[0] {bins ui_in0 [] ={0,1};}
    d:coverpoint sub.ui_in[1] {bins ui_in1 []={0,1};}
    e:coverpoint sub.ui_in[2] {bins ui_in2 [] ={0,1};}
    f:coverpoint sub.ui_in[3] {bins ui_in3 []={0,1};}
    g:coverpoint sub.ui_in[7:4] {bins ui_in_7_4 [] ={[15:0]};}
    h:coverpoint sub.uio_in ;

   i:cross c,d;
   j:cross e,f;

  // output coverage
    k:coverpoint sub.uo_out[0] {bins ui_out0 [] ={0,1};}
    l:coverpoint sub.uo_out[1] {bins ui_out1 []={0,1};}
    m:coverpoint sub.uo_out[2] {bins ui_out2 [] ={0,1};}
    n:coverpoint sub.uo_out[3] {bins ui_out3 []={0,1};}
    o:coverpoint sub.uo_out[7:4] {bins wr_ptr [] ={[3:0]};}
    p:coverpoint sub.uio_out ;
   q:coverpoint sub.uio_oe {bins oe [] ={0,255};}

   r: cross k,l {
    bins busy_ready_01 = binsof(k) intersect {0} && binsof(l) intersect {1};

    bins busy_ready_10 = binsof(k) intersect {1} && binsof(l) intersect {0};}

  s: cross l,m {
    bins busy_ready_01 = binsof(m) intersect {0} && binsof(l) intersect {1};

    bins busy_ready_11 = binsof(m) intersect {1} && binsof(l) intersect {1};}

 t: cross n,o {
    bins ready_wr_ptr = binsof(o) intersect{[2:0]} && binsof (n) intersect {0};
     bins ready_wr_ptr_1 = binsof(o) intersect{3} && binsof (n) intersect {1}; }

  endgroup

 function new(string name="fpu_subscriber",uvm_component parent);
super.new(name,parent);
 cg=new();
endfunction

function void report_phase(uvm_phase phase);
super.report_phase(phase);
    `uvm_info(get_name,$sformatf(" COVERAGE = %0f",cg.get_coverage()),UVM_NONE)
     //input coverage
  `uvm_info("COVERAGE",$sformatf("rst_n = %0.2f%%",cg.a.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("ena = %0.2f%%",cg.b.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("ui_in[0]= %0.2f%%",cg.c.get_coverage()),UVM_LOW)
       `uvm_info("COVERAGE",$sformatf("ui_in[1] = %0.2f%%",cg.d.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("ui_in[2] = %0.2f%%",cg.e.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("ui_in [3] = %0.2f%%",cg.f.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("ui_in [7:4] = %0.2f%%",cg.g.get_coverage()),UVM_LOW)
          `uvm_info("COVERAGE",$sformatf(" uio_in = %0.2f%%",cg.h.get_coverage()),UVM_LOW)
         `uvm_info("COVERAGE",$sformatf("wr_rd = %0.2f%%",cg.i.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("start_opcode = %0.2f%%",cg.j.get_coverage()),UVM_LOW)


       //output coverage
  `uvm_info("COVERAGE",$sformatf("uo_out[0] = %0.2f%%",cg.k.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("uo_out[1] = %0.2f%%",cg.l.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("uo_out[2]= %0.2f%%",cg.m.get_coverage()),UVM_LOW)
       `uvm_info("COVERAGE",$sformatf("uo_out[3] = %0.2f%%",cg.n.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("wr_ptr = %0.2f%%",cg.o.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("uio_out = %0.2f%%",cg.p.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("uio_oe  = %0.2f%%",cg.q.get_coverage()),UVM_LOW)
          `uvm_info("COVERAGE",$sformatf(" busy_done = %0.2f%%",cg.r.get_coverage()),UVM_LOW)
         `uvm_info("COVERAGE",$sformatf("done_error = %0.2f%%",cg.s.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("ready_wr_ptr = %0.2f%%",cg.t.get_coverage()),UVM_LOW)


endfunction


function void write(seq_item t);
sub=t;
cg.sample();
endfunction
endclass

