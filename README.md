# CPU

Our second version of CPU

# Group

NonExist

# Members

张钰晖

杨一滨

周正平

# Function Test

- 算术运算指令（共12(0xC)条）

| 序号   | 测试程序  | 功能测试点                               | 仿真结果 | 25MHz时钟 |
| :--- | :---- | :---------------------------------- | ---- | ------- |
| 1    | ADD   | 执行 ADD 指令是否产生正确的运算结果（未测试整型溢出例外的情况）  | P    | P       |
| 2    | ADDI  | 执行 ADDI 指令是否产生正确的运算结果（未测试整型溢出例外的情况） | P    | P       |
| 3    | ADDU  | 执行 ADDU 指令是否产生正确的运算结果               | P    | P       |
| 4    | ADDIU | 执行 ADDIU 指令是否产生正确的运算结果              | P    | P       |
| 5    | SUB   | 执行 SUB 指令是否产生正确的运算结果（未测试整型溢出例外的情况）  | P    | P       |
| 6    | SUBU  | 执行 SUBU 指令是否产生正确的运算结果               | P    | P       |
| 7    | SLT   | 执行 SLT 指令是否产生正确的运算结果                | P    | P       |
| 8    | SLTI  | 执行 SLTI 指令是否产生正确的运算结果               | P    | P       |
| 9    | SLTU  | 执行 SLTU 指令是否产生正确的运算结果               | P    | P       |
| 10   | SLTIU | 执行 SLTIU 指令是否产生正确的运算结果              | P    | P       |
| 11   | DIV   | 执行 DIV 指令是否产生正确的运算结果                | N    | N       |
| 12   | DIVU  | 执行 DIVU 指令是否产生正确的运算结果               | N    | N       |
| 13   | MULT  | 执行 MULT 指令是否产生正确的运算结果               | P    | P       |
| 14   | MULTU | 执行 MULTU 指令是否产生正确的运算结果              | P    | P       |

- 逻辑运算指令（共14(0xE)条）

| 序号   | 测试程序 | 功能测试点                 | 仿真结果 | 25MHz时钟 |
| :--- | :--- | :-------------------- | ---- | ------- |
| 15   | AND  | 执行 AND 指令是否产生正确的运算结果  | P    | P       |
| 16   | ANDI | 执行 ANDI 指令是否产生正确的运算结果 | P    | P       |
| 17   | LUI  | 执行 LUI 指令是否产生正确的运算结果  | P    | P       |
| 18   | NOR  | 执行 NOR 指令是否产生正确的运算结果  | P    | P       |
| 19   | OR   | 执行 OR 指令是否产生正确的运算结果   | P    | P       |
| 20   | ORI  | 执行 ORI 指令是否产生正确的运算结果  | P    | P       |
| 21   | XOR  | 执行 XOR 指令是否产生正确的运算结果  | P    | P       |
| 22   | XORI | 执行 XORI 指令是否产生正确的运算结果 | P    | P       |
| 23   | SLLV | 执行 SLLV 指令是否产生正确的移位结果 | P    | P       |
| 24   | SLL  | 执行 SLL 指令是否产生正确的移位结果  | P    | P       |
| 25   | SRAV | 执行 SRAV 指令是否产生正确的移位结果 | P    | P       |
| 26   | SRA  | 执行 SRA 指令是否产生正确的移位结果  | P    | P       |
| 27   | SRLV | 执行 SRLV 指令是否产生正确的移位结果 | P    | P       |
| 28   | SRL  | 执行 SRL 指令是否产生正确的移位结果  | P    | P       |

- 分支跳转指令（共10(0xA)条）

| 序号   | 测试程序   | 功能测试点                                    | 仿真结果 | 25MHz时钟 |
| :--- | :----- | :--------------------------------------- | ---- | ------- |
| 29   | BEQ    | 执行 BEQ 指令是否产生正确的判断和跳转结果（延迟槽指令为nop，未测试延迟槽） | P    | P       |
| 30   | BNE    | 执行 BNE 指令是否产生正确的判断和跳转结果（延迟槽指令为nop，未测试延迟槽） | P    | P       |
| 31   | BGEZ   | 执行 BGEZ 指令是否产生正确的判断和跳转结果（延迟槽指令为 nop，未测试延迟槽） | P    | P       |
| 32   | BGTZ   | 执行 BGTZ 指令是否产生正确的判断和跳转结果（延迟槽指令为 nop，未测试延迟槽） | P    | P       |
| 33   | BLEZ   | 执行 BLEZ 指令是否产生正确的判断和跳转结果（延迟槽指令为 nop，未测试延迟槽） | P    | P       |
| 34   | BLTZ   | 执行 BLTZ 指令是否产生正确的判断和跳转结果（延迟槽指令为 nop，未测试延迟槽） | P    | P       |
| 35   | BGEZAL | 执行 BGEZAL 指令是否产生正确的判断、跳转和链接结果（延迟槽指令为 nop，未测试延迟槽） | N    | N       |
| 36   | BLTZAL | 执行 BLTZAL 指令是否产生正确的判断、跳转和链接结果（延迟槽指令为 nop，未测试延迟槽） | N    | N       |
| 37   | J      | 执行 J 指令是否产生正确的跳转结果（延迟槽指令为 nop，未测试延迟槽）    | P    | P       |
| 38   | JAL    | 执行 JAL 指令是否产生正确的跳转和链接结果（延迟槽指令为nop，未测试延迟槽） | P    | P       |
| 39   | JR     | 执行 JR 指令是否产生正确的跳转结果（延迟槽指令为 nop，未测试延迟槽）   | P    | P       |
| 40   | JALR   | 执行 JALR 指令是否产生正确的跳转和链接结果（延迟槽指令为 nop，未测试延迟槽） | P    | P       |

- HILO寄存器指令（共4(0x4)条）

| 序号   | 测试程序 | 功能测试点                                    | 仿真结果 | 25MHz时钟 |
| :--- | :--- | :--------------------------------------- | ---- | ------- |
| 41   | MFHI | 执行 MTHI 指令是否正确地将寄存器值写入 HI 寄存器，执行MFHI 指令是否正确地读出 HI 寄存器的值到寄存器 | P    | P       |
| 42   | MFLO | 执行 MTLO 指令是否正确地将寄存器值写入 LO 寄存器，执行MFLO 指令是否正确地读出 LO 寄存器的值到寄存器 | P    | P       |
| 43   | MTHI | 执行 MTHI 指令是否正确地将寄存器值写入 HI 寄存器，执行MFHI 指令是否正确地读出 HI 寄存器的值到寄存器 | P    | P       |
| 44   | MTLO | 执行 MTLO 指令是否正确地将寄存器值写入 HI 寄存器，执行MFLO 指令是否正确地读出 HI 寄存器的值到寄存器 | P    | P       |


- CP0指令（共4(0x4)条）

| 序号   | 测试程序    | 功能测试点                                    | 仿真结果 | 25MHz时钟 |
| :--- | :------ | :--------------------------------------- | ---- | ------- |
| 45   | BREAK   | 执行 BREAK 指令是否正确地产生断点例外                   | N    | N       |
| 46   | SYSCALL | 执行 SYSCALL 指令是否正确地产生系统调用例外               | P    | P       |
| 55   | ERET    | 执行 ERET 指令是否正确地从中断、例外处理程序返回              | P    | P       |
| 56   | MFC0    | 执行 MTC0 指令是否正确地将寄存器值写入目的 CP0 寄存器，执行 MFC0 指令是否正确地读出源 CP0 寄存器的值到寄存器 | P    | P       |
| 57   | MTC0    | 执行 MTC0 指令是否正确地将寄存器值写入目的 CP0 寄存器，执行 MFC0 指令是否正确地读出源 CP0 寄存器的值到寄存器 | P    | P       |

- 访存指令（共8(0x8)条）

| 序号   | 测试程序 | 功能测试点                         | 仿真结果 | 25MHz时钟 |
| :--- | :--- | :---------------------------- | ---- | ------- |
| 47   | LB   | 结合 SW 指令，执行 LB 指令是否产生正确的访存结果  | P    | P       |
| 48   | LBU  | 结合 SW 指令，执行 LBU 指令是否产生正确的访存结果 | P    | P       |
| 49   | LH   | 结合 SW 指令，执行 LH 指令是否产生正确的访存结果  | P    | P       |
| 50   | LHU  | 结合 SW 指令，执行 LHU 指令是否产生正确的访存结果 | P    | P       |
| 51   | LW   | 结合 SW 指令，执行 LW 指令是否产生正确的访存结果  | P    | P       |
| 52   | SB   | 结合 LW 指令，执行 SB 指令是否产生正确的访存结果  | P    | P       |
| 53   | SH   | 结合 LW 指令，执行 SH 指令是否产生正确的访存结果  | P    | P       |
| 54   | SW   | 结合 LW 指令，执行 SW 指令是否产生正确的访存结果  | P    | P       |

- 异常指令（共13(0xD)条）

| 序号   | 测试程序                      | 功能测试点              | 仿真结果 | 25MHz时钟 |
| :--- | :------------------------ | :----------------- | ---- | ------- |
| 58   | ADD\_EX                   | 测试 ADD 指令整型溢出例外    | P    | P       |
| 59   | ADDI\_EX                  | 测试 ADDI 指令整型溢出例外   | P    | P       |
| 60   | SUB\_EX                   | 测试 SUB 指令整型溢出例外    | P    | P       |
| 61   | LH\_EX                    | 测试 LH 指令访存地址非对齐例外  | N    | N       |
| 62   | LHU\_EX                   | 测试 LHU 指令访存地址非对齐例外 | N    | N       |
| 63   | LW\_EX                    | 测试 LW 指令访存地址非对齐例外  | N    | N       |
| 64   | SH\_EX                    | 测试 SH 指令访存地址非对齐例外  | N    | N       |
| 65   | SW\_EX                    | 测试 SW 指令访存地址非对齐例外  | N    | N       |
| 66   | ERET\_EX                  | 测试取指地址非对齐例外        | N    | N       |
| 67   | RESERVED\_INSTRUCTION\_EX | 测试保留指令例外           | N    | N       |
| 80   | BEQ\_EX\_DS               | 测试延迟槽例外            | P    | P       |
| 81   | BNE\_EX\_DS               | 测试延迟槽例外            | P    | P       |
| 82   | BGEZ\_EX\_DS              | 测试延迟槽例外            | P    | P       |
| 83   | BGTZ\_EX\_DS              | 测试延迟槽例外            | P    | P       |
| 84   | BLEZ\_EX\_DS              | 测试延迟槽例外            | P    | P       |
| 85   | BLTZ\_EX\_DS              | 测试延迟槽例外            | P    | P       |
| 86   | BGEZAL\_EX\_DS            | 测试延迟槽例外            | N    | N       |
| 87   | BLTZAL\_EX\_DS            | 测试延迟槽例外            | N    | N       |
| 88   | J\_EX\_DS                 | 测试延迟槽例外            | P    | P       |
| 89   | JAL\_EX\_DS               | 测试延迟槽例外            | P    | P       |
| 90   | JR\_EX\_DS                | 测试延迟槽例外            | P    | P       |
| 91   | JALR\_EX\_DS              | 测试延迟槽例外            | P    | P       |


- 延迟槽指令（共10(0xA)条）

| 序号   | 测试程序       | 功能测试点 | 仿真结果 | 25MHz时钟 |
| :--- | :--------- | :---- | ---- | ------- |
| 68   | BEQ\_DS    | 测试延迟槽 | P    | P       |
| 69   | BNE\_DS    | 测试延迟槽 | P    | P       |
| 70   | BGEZ\_DS   | 测试延迟槽 | P    | P       |
| 71   | BGTZ\_DS   | 测试延迟槽 | P    | P       |
| 72   | BLEZ\_DS   | 测试延迟槽 | P    | P       |
| 73   | BLTZ\_DS   | 测试延迟槽 | P    | P       |
| 74   | BGEZAL\_DS | 测试延迟槽 | N    | N       |
| 75   | BLTZAL\_DS | 测试延迟槽 | N    | N       |
| 76   | J\_DS      | 测试延迟槽 | P    | P       |
| 77   | JAL\_DS    | 测试延迟槽 | P    | P       |
| 78   | JR\_DS     | 测试延迟槽 | P    | P       |
| 79   | JALR\_DS   | 测试延迟槽 | P    | P       |

> 功能测例自己会破坏自己，使用一个ram，仿真结果46，板子47，实际应该4b？！