module Ejercicio_1_tb();

reg clk_PC,reset_PC,enable_PC,load_PC;
reg clk_Fetch,reset_Fetch, enable_Fetch;
reg [11:0] RAM;
wire [7:0] Program_Byte;
wire [3:0] Instr,Oprnd;

//instancia
Conjunto c1(clk_PC,reset_PC,enable_PC,load_PC, RAM,Program_Byte,clk_Fetch,reset_Fetch,enable_Fetch,Instr,Oprnd);




initial begin
   #1 $display(" ");
   $display(" ");
   $display("Implementación de ejercicio 1");
   $display("CP  RP  LP  CF RF EP|     PB     IT   OD");
   $display("____________________|______________________");
   $monitor(" %b    %b  %b   %b   %b %b    %b %b %b | ", clk_PC,reset_PC,load_PC,clk_Fetch,reset_Fetch,enable_PC,Program_Byte,Instr,Oprnd);
   end


    always
    #10 clk_PC = ~clk_PC;
    always
    #10 clk_Fetch = ~clk_Fetch;

initial begin


 RAM = 12'b000000000011;
 clk_PC=0; clk_Fetch=0;

// Valores iniciales
 reset_PC=1; reset_Fetch=1;
 enable_PC=0; enable_Fetch=0; load_PC=0;
///// Comienza programa
//// Contador
#10 reset_PC=0; enable_PC=1;
#10 enable_PC=1; enable_PC=1;
#10 enable_PC=1; enable_PC=1;
#10 enable_PC=1; enable_PC=1;
#10 enable_PC=1; enable_PC=1;
#10 reset_PC=1; reset_PC=0;
#10 load_PC=1; #10 load_PC=0;
#10 enable_PC=1; enable_PC=1;
#10 enable_PC=1; enable_PC=1;
#10 enable_PC=1; enable_PC=1;
#10 enable_PC=1; enable_PC=1;

////
#10 reset_Fetch=0; enable_Fetch=0;
#10 enable_Fetch=1; #10 enable_Fetch=1;
#10 enable_PC=1; #10 enable_PC=1;
#10 enable_PC=1;#10 enable_PC=1;

/////////////////////
#10 reset_PC=1;#10  reset_Fetch=1;


$finish;
end


initial begin
 $dumpfile("Ejercicio_1_tb.vcd");
  $dumpvars(0,Ejercicio_1_tb);
end



endmodule
