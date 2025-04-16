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
