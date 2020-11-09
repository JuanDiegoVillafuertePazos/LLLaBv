module Ejercicio_2_tb();

reg Control_1,Control_2,reset_ALU,reset_acumulador,enable_acumulador,almacen,clk_ALU,enable_ALU;
reg [3:0] Entrada;
reg [2:0] Configuracion_ALU;
wire [3:0] data_bus,salida_ALU,accu,salida_total;
wire [1:0] C_ALU,Z_ALU;

//instancia
Conjunto c1(Entrada,Control_1,Control_2,data_bus,clk_ALU,reset_ALU,Configuracion_ALU,accu,C_ALU,Z_ALU,reset_acumulador,enable_acumulador,salida_ALU,almacen,salida_ALU , salida_total,enable_ALU);




initial begin
   #1 $display(" ");
   $display(" ");
   $display("Implementación ejercicio 2");
   $display("CLK  Entrada  CTR1  CTR2 RAl EA|  RAc  Ena AL   SA ST");
   $display("_____________________________________________|_________");
   $monitor(" %b     %b      %b     %b   %b   %b      %b  %b  %b | %b %b ", clk_ALU,Entrada,Control_1,Control_2,reset_ALU,enable_ALU,reset_acumulador,enable_acumulador,almacen,salida_ALU, salida_total);
   end


    always
    #10 clk_ALU = ~clk_ALU;


initial begin
clk_ALU=0;

 #10 Entrada =  4'b0001; Control_1=0; Control_2=0;reset_ALU=1; reset_acumulador=1;enable_ALU=0;enable_acumulador=0; almacen=0;
 #10 Control_1=1; Configuracion_ALU= 3'b010; almacen=1; enable_acumulador=1; Entrada = 4'b0101;
 #10  Configuracion_ALU=4'b001;





$finish;
end


initial begin
$dumpfile("Ejercicio_2_tb.vcd");
$dumpvars(0,Ejercicio_2_tb);
end



endmodule
