module non_restoring_sqrt (
    input  [31:0] D,
    output [15:0] Q,
    output [16:0] R
);
    reg [15:0] q_reg;
    reg signed [17:0] r_reg; // 1 bit wider to hold intermediate negative values
    reg [1:0] next2bits;
    integer i;

    always @(*) begin
        q_reg = 16'd0;
        r_reg = 18'sd0;

        for (i = 15; i >= 0; i = i - 1) begin
            
            next2bits = (D >> (2*i)) & 2'b11;

            r_reg = (r_reg <<< 2) | next2bits;

            if (r_reg >= 0)
                r_reg = r_reg - $signed({q_reg, 2'b01}); // subtract (Q << 2 | 1)
            else
                r_reg = r_reg + $signed({q_reg, 2'b11}); // add (Q << 2 | 3)

            if (r_reg >= 0)
                q_reg = (q_reg << 1) | 1'b1;
            else
                q_reg = (q_reg << 1);
        end

        // Final remainder adjustment (use final Q!)
        if (r_reg < 0)
            r_reg = r_reg + $signed({q_reg, 1'b1}); // R = R + (Q << 1 | 1)
    end

    assign Q = q_reg;
    assign R = r_reg[16:0]; // Truncate to 17 bits

endmodule


`timescale 1ns / 1ps

module tb_non_restoring_sqrt;

    reg  [31:0] D;
    wire [15:0] Q;
    wire [16:0] R;

    // Instantiate the module
    non_restoring_sqrt uut (
        .D(D),
        .Q(Q),
        .R(R)
    );

    initial begin
        // Monitor signals in binary format
        $display("Time\t\tD \t\tQ \t\tR");
        $monitor("%0t\t%d\t%d\t%d", $time, D, Q, R);

        // Test cases
        D = 32'd0;         #10;
        D = 32'd1;         #10;
        D = 32'd4;         #10;
        D = 32'd9;         #10;
        D = 32'd15;        #10;
        D = 32'd16;        #10;
        D = 32'd100;       #10;
        D = 32'd169;       #10;
        D = 32'd255;       #10;
        D = 32'd256;       #10;
        D = 32'd1024;      #10;
        D = 32'd40000;     #10;
        D = 32'd65536;     #10;
        D = 32'd1048576;   #10; // 2^20
        D = 32'd4294705156;#10;
        D = 32'd4294967295;#10; // Max 32-bit unsigned

        $finish;
    end

endmodule
