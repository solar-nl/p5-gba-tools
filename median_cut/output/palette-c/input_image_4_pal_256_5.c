#include "memory.h"
unsigned short EWRAM_DATA generated_palette[256];
const unsigned short input_image_4[256] = {
0x0400, 0x0420, 0x0421, 0x0421, 0x0422, 0x0422, 0x0422, 0x0422, 0x0821, 0x0821, 0x0822, 0x0C42, 0x0422, 0x0822, 0x0842, 0x0C42, 
0x0423, 0x0424, 0x0823, 0x0824, 0x0443, 0x0843, 0x0444, 0x0444, 0x0843, 0x0843, 0x0844, 0x0844, 0x0843, 0x0C63, 0x0844, 0x0C64, 
0x0444, 0x0844, 0x0445, 0x0845, 0x0844, 0x0844, 0x0845, 0x0845, 0x0845, 0x0865, 0x0465, 0x0865, 0x0C44, 0x0C64, 0x0C45, 0x0C65, 
0x0446, 0x0846, 0x0C46, 0x0C46, 0x0866, 0x0867, 0x0C66, 0x0C66, 0x0868, 0x0C68, 0x0888, 0x0889, 0x086A, 0x086C, 0x088A, 0x0CAC, 
0x1041, 0x1063, 0x1063, 0x1483, 0x1064, 0x1065, 0x1085, 0x1485, 0x1066, 0x1087, 0x1086, 0x1087, 0x1087, 0x1087, 0x14A6, 0x14A7, 
0x1088, 0x1089, 0x1089, 0x14A9, 0x108A, 0x148A, 0x108B, 0x108C, 0x14A8, 0x14AA, 0x14A9, 0x14CA, 0x14AB, 0x14AD, 0x14CB, 0x14ED, 
0x1CA3, 0x1CA4, 0x1CA5, 0x20E6, 0x18C9, 0x18CA, 0x20E9, 0x1D0B, 0x18CC, 0x18EC, 0x1CEC, 0x1CEC, 0x1D0D, 0x210C, 0x210D, 0x212D, 
0x28E5, 0x2907, 0x2929, 0x3149, 0x252D, 0x292C, 0x294C, 0x316C, 0x3948, 0x358B, 0x3D8A, 0x4D87, 0x45CB, 0x45CD, 0x5E0A, 0x726A, 
0x088E, 0x108E, 0x0891, 0x0CB1, 0x0CAF, 0x0CEF, 0x08F1, 0x10D1, 0x14CE, 0x14D0, 0x18EE, 0x1511, 0x1D0E, 0x1D10, 0x252E, 0x2530, 
0x08B3, 0x08B5, 0x0913, 0x0915, 0x10D4, 0x1114, 0x14F3, 0x1914, 0x04D7, 0x0917, 0x04FA, 0x093B, 0x0D17, 0x1517, 0x1119, 0x0D3B, 
0x1D71, 0x2570, 0x2D6E, 0x2991, 0x0D77, 0x1576, 0x2174, 0x25B5, 0x097A, 0x05BA, 0x057D, 0x05DE, 0x0D9A, 0x0D9C, 0x159B, 0x21BB, 
0x0A3B, 0x2239, 0x0A5D, 0x1A5D, 0x023E, 0x027E, 0x065E, 0x167E, 0x0ADE, 0x06FF, 0x071E, 0x0B7F, 0x1AFE, 0x271E, 0x1FBF, 0x2BBE, 
0x316E, 0x358E, 0x3190, 0x3590, 0x39AF, 0x3DCF, 0x39D1, 0x3DF1, 0x45EE, 0x41F0, 0x4A0F, 0x4611, 0x4E0F, 0x4E31, 0x5250, 0x564F, 
0x31B3, 0x35B3, 0x39D3, 0x3A13, 0x35B5, 0x39F5, 0x3617, 0x363B, 0x41F2, 0x4633, 0x4A33, 0x5252, 0x4634, 0x4E54, 0x4A55, 0x4A57, 
0x4E74, 0x5693, 0x5A92, 0x5A95, 0x3EB9, 0x4EB8, 0x5696, 0x56D7, 0x3ADC, 0x3B7E, 0x4EBB, 0x535D, 0x37BE, 0x47DF, 0x53DE, 0x57DE, 
0x5E91, 0x6AD1, 0x5EB4, 0x66D4, 0x6AF4, 0x7B32, 0x6B15, 0x7755, 0x5ED6, 0x633A, 0x7356, 0x6F59, 0x739B, 0x7FDA, 0x5FDE, 0x73DE
};