module washing_machine_tb;

    // Inputs to the washing machine
    logic       clk;
    logic       reset;
    logic [3:0] password;
    logic       enter_password;
    logic       start;

    // Outputs from the washing machine
    logic       unlocked;
    logic       alarm;
    logic       wash;
    logic       rinse;
    logic       dry;
    logic       stop;

    // Create the washing machine
    washing_machine uut (
        .clk(clk),
        .reset(reset),
        .password(password),
        .enter_password(enter_password),
        .start(start),
        .unlocked(unlocked),
        .alarm(alarm),
        .wash(wash),
        .rinse(rinse),
        .dry(dry),
        .stop(stop)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin

        // Initial values
        clk = 0;
        reset = 1;
        password = 4'b0000;
        enter_password = 0;
        start = 0;

        // Reset
        #10;
        reset = 0;

        // --------------------------------
        // Test wrong password
        // --------------------------------
        #10;
        password = 4'b1111;
        enter_password = 1;

        #10;
        enter_password = 0;

        // --------------------------------
        // Test correct password
        // --------------------------------
        #10;
        password = 4'b1010;
        enter_password = 1;

        #10;
        enter_password = 0;

        // --------------------------------
        // Press START
        // --------------------------------
        #10;
        start = 1;

        #10;
        start = 0;

        // --------------------------------
        // Allow washing cycle to run
        // --------------------------------
        #150;

        // End simulation
        $stop;

    end

endmodule