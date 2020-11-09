module  Conjunto(Entrada,Control_1,Control_2,data_bus,clk_ALU,reset_ALU,Configuracion_ALU,accu,C_ALU,Z_ALU,
  reset_acumulador,enable_acumulador,salida_ALU,almacen,salida_ALU , salida_total,enable_ALU);


input wire enable_ALU,clk_ALU,Control_1,Control_2,reset_ALU,reset_acumulador,enable_acumulador,almacen;
input wire [3:0] Entrada;
input wire [2:0] Configuracion_ALU;
output wire [3:0] data_bus,salida_ALU,accu,salida_total;
output wire [1:0] C_ALU,Z_ALU;

///// señales clk y reset para el acumulador, de control  para buffers
// señal de control para ALU


Bus_driver1 f1(Entrada,Control_1,data_bus);
ALU f2(clk_ALU,reset_ALU,enable_ALU,Configuracion_ALU,data_bus,accu,salida_ALU,C_ALU,Z_ALU);
Acumulador f3(clk_ALU,reset_acumulador,enable_acumulador,salida_ALU,accu,almacen);
Bus_driver2 f4(salida_ALU,Control_2,salida_total);

endmodule

module Bus_driver1(a,enable,salida);

input  [3:0] a;
input  enable;
output  [3:0] salida;

assign salida = enable ? a : 4'bZZZZ;

endmodule

module ALU(clk,reset,enable,operacion,Entrada, acumulador,salida,c,z);

input wire clk,reset,enable;
input wire [2:0] operacion;
input wire [3:0] Entrada, acumulador;
output reg [3:0] salida;
output reg [1:0] c,z;

always @(posedge Entrada or posedge operacion or posedge acumulador)

begin
casez(operacion)
3'b000: salida = acumulador ; // dejar pasar accu
3'b001: salida = acumulador - Entrada;// resta
3'b010: salida = Entrada;//  dejar pasar data_bus
3'b011: salida = acumulador + Entrada;// Suma
3'b100: salida = ~(acumulador & Entrada);// NAND
3'b000: z = 1'b1;
4'bzzz: c =1'b1;

endcase
end
endmodule

module Acumulador(clk,reset,enable,entrada,salida,almacen);

input wire clk,reset,enable,almacen;
input wire [3:0] entrada;
output reg [3:0] salida;
reg [3:0] almacen1;

always @(posedge enable or posedge clk)
begin
if (almacen) almacen1 = entrada;
else if (enable) salida = almacen;

end

endmodule


module Bus_driver2(a,enable,salida);

input  [3:0] a;
input  enable;
output  [3:0] salida;

assign salida = enable ? a : 4'bZZZZ;

endmodule
