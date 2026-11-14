class fpu_cfg extends uvm_objects;

    `uvm_objct_utils(fpu_cfg)

    function new(string name="");
        super.new(name);
    endfunction

    virtual fpu_if intrf;

    uvm_active_passive_enum ip_agent;
    uvm_active_passive_enum op_agent;

endclass