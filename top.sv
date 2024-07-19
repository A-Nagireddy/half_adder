module top();
	

	import router_test_pkg::*;
	
	import uvm_pkg::*;
	
	`include "uvm_macros.svh"

	bit clock;
	
	always
	#10 clock=!clock;

	
	router_src_if in0(clock);
	router_dst_if in1(clock);
	router_dst_if in2(clock);
	router_dst_if in3(clock);
	
	router_top DUV(.clock(clock),
			.resetn(in0.rst),
			.pkt_valid(in0.pkt_vld),
			.data_in(in0.data_in),
			.err(in0.error),
			.busy(in0.busy),
			
			.data_out_0(in1.dout),
			.read_enb_0(in1.rd_enb),
			.vldout_0(in1.vld_out),

			.data_out_1(in2.dout),
			.read_enb_1(in2.rd_enb),
			.vldout_1(in2.vld_out),

			.data_out_2(in3.dout),
			.read_enb_2(in3.rd_enb),
			.vldout_2(in3.vld_out));

	
			initial 
		begin

			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif
			
			uvm_config_db #(virtual router_src_if)::set(null,"*","vif_0",in0);
			uvm_config_db #(virtual router_dst_if )::set(null,"*","vif_0",in1);
			uvm_config_db #(virtual router_dst_if)::set(null,"*","vif_1",in2);
			uvm_config_db #(virtual router_dst_if)::set(null,"*","vif_2",in3);

			run_test();
		end   
endmodule
