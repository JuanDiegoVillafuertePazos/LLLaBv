module  Conjunto(clk_PC,reset_PC,enable_PC,load_PC,direccion,
  Program_Byte, clk_Fetch,reset_Fetch,enable_Fetch,Instr,Oprnd);

input wire clk_PC,reset_PC,enable_PC,load_PC,clk_Fetch,
reset_Fetch,enable_Fetch;

input wire [11:0] direccion;
output wire [7:0] Program_Byte;
output wire [3:0] Instr,Oprnd;

wire [11:0] PC;



Program_counter P1(clk_PC, reset_PC, enable_PC, load_PC, direccion, PC);
Program_ROM P2(PC,Program_Byte);
Fetch p3(clk_Fetch,reset_Fetch,enable_Fetch, Program_Byte, Instr, Oprnd);

endmodule

////////////////////////////// Program_Counter
module Program_counter(clk, reset, enable, load ,D,Q);

input wire clk, reset, enable, load;
input wire [11:0] D;
output reg [11:0] Q;

always @(posedge clk or posedge reset or posedge load)
   begin
     if (reset) Q <= 0;
     else if (load) Q <= D;
     else if (enable) Q <= Q+1;
     else Q <= Q;
   end
endmodule
/////////////////////////////  Program_memory 64X8
module Program_ROM(direccion,OUT);

input wire [11:0] direccion;
output wire [7:0] OUT;

reg [7:0] memory[0:4095];

initial begin
  $readmemb("memory.list",memory);
end

assign OUT = memory[direccion];

endmodule
////////////////////// Fetch como un flip-flop


module FFD(input wire clk,
           input wire reset,
           input wire enable,
           input wire D,
           output reg Q);

  always @(posedge clk or posedge reset or posedge enable)
    begin
      if (reset) Q <= 1'b0;
      else if (enable) Q <= D;
      else Q <= Q;
    end

endmodule
/// configuración del flip-flop

module flip_flop(clk,reset,enable,D,Q);

input wire clk,reset,enable;
input wire [7:0] D;
output wire [7:0] Q;

FFD F1(clk, reset, enable, D[7], Q[7]);
FFD F2(clk, reset, enable, D[6], Q[6]);
FFD F3(clk, reset, enable, D[5], Q[5]);
FFD F4(clk, reset, enable, D[4], Q[4]);

FFD F5(clk, reset, enable, D[3], Q[3]);
FFD F6(clk, reset, enable, D[2], Q[2]);
FFD F7(clk, reset, enable, D[1], Q[1]);
FFD F8(clk, reset, enable, D[0], Q[0]);
endmodule

/////////////////////////// Fetch

module Fetch(clk,reset,enable,D,comando,fetch);

input wire clk,reset,enable;
input wire [7:0] D;
output wire [3:0] comando, fetch;

FFD F1(clk, reset, enable, D[7], comando[3]);
FFD F2(clk, reset, enable, D[6], comando[2]);
FFD F3(clk, reset, enable, D[5], comando[1]);
FFD F4(clk, reset, enable, D[4], comando[0]);

FFD F5(clk, reset, enable, D[3], fetch[3]);
FFD F6(clk, reset, enable, D[2], fetch[2]);
FFD F7(clk, reset, enable, D[1], fetch[1]);
FFD F8(clk, reset, enable, D[0], fetch[0]);
endmodule
