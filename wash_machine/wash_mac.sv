module washing_machine (
    input  logic       clk,
    input  logic       reset,

    // Password
    input  logic [3:0] password,
    input  logic       enter_password,

    // Start button
    input  logic       start,

    // Outputs
    output logic       unlocked,
    output logic       alarm,
    output logic       wash,
    output logic       rinse,
    output logic       dry,
    output logic       stop
);

    // Password
    parameter logic [3:0] CORRECT_PASSWORD = 4'b1010;

    // FSM states
    typedef enum logic [2:0] {
        IDLE,
        WASH,
        RINSE,
        DRY,
        STOP
    } state_t;

    state_t state;

    // Counter
    logic [2:0] count;

    // Password verification
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            unlocked <= 0;
        end
        else if (enter_password) begin
            if (password == CORRECT_PASSWORD)
                unlocked <= 1;
            else
                unlocked <= 0;
        end
    end

    // FSM
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
        end
        else begin

            case (state)

                IDLE: begin
                    count <= 0;

                    if (unlocked && start)
                        state <= WASH;
                end

                WASH: begin
                    if (count == 3) begin
                        count <= 0;
                        state <= RINSE;
                    end
                    else
                        count <= count + 1;
                end

                RINSE: begin
                    if (count == 3) begin
                        count <= 0;
                        state <= DRY;
                    end
                    else
                        count <= count + 1;
                end

                DRY: begin
                    if (count == 3) begin
                        count <= 0;
                        state <= STOP;
                    end
                    else
                        count <= count + 1;
                end

                STOP: begin
                    count <= 0;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                    count <= 0;
                end

            endcase
        end
    end

    // Outputs
    always_comb begin

        // Default values
        wash  = 0;
        rinse = 0;
        dry   = 0;
        stop  = 0;
        alarm = 0;

        case (state)

            IDLE: begin
                alarm = 0;
            end

            WASH: begin
                wash  = 1;
                alarm = 1;
            end

            RINSE: begin
                rinse = 1;
                alarm = 1;
            end

            DRY: begin
                dry   = 1;
                alarm = 1;
            end

            STOP: begin
                stop  = 1;
                alarm = 1;
            end

            default: begin
                alarm = 0;
            end

        endcase
    end

endmodule