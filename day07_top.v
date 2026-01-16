module day07_top (
    rx_data,
    rx_valid,
    clear,
    clock,
    part1,
    part2,
    done_
);

    input [7:0] rx_data;
    input rx_valid;
    input clear;
    input clock;
    output [63:0] part1;
    output [63:0] part2;
    output done_;

    wire gnd;
    wire [63:0] _17;
    wire [15:0] _19;
    wire [63:0] _20;
    wire [63:0] _21;
    wire [63:0] _2;
    reg [63:0] _18;
    wire [47:0] _63;
    wire [47:0] _55;
    reg [47:0] _52;
    wire [47:0] _53;
    wire [47:0] _49;
    wire [7:0] _34;
    wire _35;
    wire [47:0] _48;
    wire [7:0] _32;
    wire _33;
    wire [47:0] _50;
    wire [7:0] _28;
    reg [7:0] _29;
    wire _31;
    wire [47:0] _54;
    wire _25;
    wire [47:0] _56;
    wire [47:0] _4;
    reg [47:0] _41[0:4095];
    wire [11:0] _38;
    wire [11:0] _36;
    wire [11:0] _57;
    wire [11:0] _58;
    wire [11:0] _5;
    reg [11:0] _37;
    wire [11:0] _39;
    reg [11:0] _40;
    wire [47:0] _42;
    reg [47:0] _44;
    reg [47:0] _46;
    wire _64;
    wire _65;
    wire [7:0] _7;
    reg [7:0] _23;
    reg [7:0] _27;
    wire _61;
    wire _9;
    wire _62;
    wire _66;
    wire _11;
    wire _13;
    wire [63:0] _68;
    wire [63:0] _69;
    wire [63:0] _14;
    reg [63:0] _67;
    assign gnd = 1'b0;
    assign _17 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _19 = 16'b0000000000000000;
    assign _20 = { _19,
                   _4 };
    assign _21 = _18 + _20;
    assign _2 = _21;
    always @(posedge _13) begin
        if (_11)
            _18 <= _17;
        else
            _18 <= _2;
    end
    assign _63 = 48'b000000000000000000000000000000000000000000000000;
    assign _55 = _54 + _44;
    always @(posedge _13) begin
        if (_11)
            _52 <= _63;
        else
            if (_9)
                _52 <= _46;
    end
    assign _53 = _50 + _52;
    assign _49 = 48'b000000000000000000000000000000000000000000000001;
    assign _34 = 8'b01011110;
    assign _35 = _27 == _34;
    assign _48 = _35 ? _63 : _46;
    assign _32 = 8'b01010011;
    assign _33 = _27 == _32;
    assign _50 = _33 ? _49 : _48;
    assign _28 = 8'b00000000;
    always @(posedge _13) begin
        if (_11)
            _29 <= _28;
        else
            if (_9)
                _29 <= _27;
    end
    assign _31 = _29 == _34;
    assign _54 = _31 ? _53 : _50;
    assign _25 = _23 == _34;
    assign _56 = _25 ? _55 : _54;
    assign _4 = _56;
    always @(posedge _13) begin
        if (_9)
            _41[_37] <= _4;
    end
    assign _38 = 12'b000001100011;
    assign _36 = 12'b000000000000;
    assign _57 = 12'b000000000001;
    assign _58 = _37 + _57;
    assign _5 = _58;
    always @(posedge _13) begin
        if (_11)
            _37 <= _36;
        else
            if (_9)
                _37 <= _5;
    end
    assign _39 = _37 - _38;
    always @(posedge _13) begin
        if (_9)
            _40 <= _39;
    end
    assign _42 = _41[_40];
    always @(posedge _13) begin
        if (_11)
            _44 <= _63;
        else
            if (_9)
                _44 <= _42;
    end
    always @(posedge _13) begin
        if (_11)
            _46 <= _63;
        else
            if (_9)
                _46 <= _44;
    end
    assign _64 = _46 == _63;
    assign _65 = ~ _64;
    assign _7 = rx_data;
    always @(posedge _13) begin
        if (_11)
            _23 <= _28;
        else
            if (_9)
                _23 <= _7;
    end
    always @(posedge _13) begin
        if (_11)
            _27 <= _28;
        else
            if (_9)
                _27 <= _23;
    end
    assign _61 = _27 == _34;
    assign _9 = rx_valid;
    assign _62 = _9 & _61;
    assign _66 = _62 & _65;
    assign _11 = clear;
    assign _13 = clock;
    assign _68 = 64'b0000000000000000000000000000000000000000000000000000000000000001;
    assign _69 = _67 + _68;
    assign _14 = _69;
    always @(posedge _13) begin
        if (_11)
            _67 <= _17;
        else
            if (_66)
                _67 <= _14;
    end
    assign part1 = _67;
    assign part2 = _18;
    assign done_ = gnd;

endmodule
