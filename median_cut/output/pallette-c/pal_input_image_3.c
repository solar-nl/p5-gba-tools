#include "memory.h"
unsigned short EWRAM_DATA generated_palette[256];
const unsigned short input_image_3[256] = {
0x0822, 0x0823, 0x0C42, 0x0C43, 0x0C62, 0x0C62, 0x0C42, 0x0C62, 0x0823, 0x0824, 0x0C43, 0x0C24, 0x0C44, 0x0C43, 0x0C44, 0x0C44, 
0x0825, 0x0C45, 0x0C44, 0x0C45, 0x0C46, 0x0C26, 0x0C46, 0x0C46, 0x0C45, 0x0C45, 0x0C45, 0x0C65, 0x0C46, 0x0C66, 0x0C47, 0x0C67, 
0x1042, 0x1442, 0x1062, 0x1462, 0x1043, 0x1443, 0x1444, 0x1463, 0x1044, 0x1444, 0x1065, 0x1465, 0x1046, 0x1446, 0x1466, 0x1467, 
0x1C42, 0x1C62, 0x1C43, 0x1C64, 0x1C44, 0x1C65, 0x1C66, 0x1C66, 0x2062, 0x2062, 0x2064, 0x2066, 0x2462, 0x2C62, 0x2465, 0x3065, 
0x0C82, 0x1483, 0x1086, 0x1886, 0x2483, 0x2484, 0x2485, 0x2486, 0x2C82, 0x2C83, 0x3482, 0x3882, 0x2C84, 0x2886, 0x3085, 0x3485, 
0x10A2, 0x14A4, 0x2CA3, 0x2CA6, 0x34A3, 0x3CA2, 0x34A4, 0x34C6, 0x10E2, 0x20E4, 0x38C4, 0x38C6, 0x1923, 0x2D23, 0x21A3, 0x3624, 
0x40A2, 0x48C1, 0x44E2, 0x4502, 0x44C4, 0x44C6, 0x44E5, 0x4506, 0x50E1, 0x5501, 0x5921, 0x6521, 0x5102, 0x5902, 0x4D06, 0x5526, 
0x4D64, 0x5D63, 0x6161, 0x6183, 0x6961, 0x6981, 0x6981, 0x6982, 0x51E4, 0x69C2, 0x6DC0, 0x6DE2, 0x5663, 0x6A82, 0x7242, 0x7704, 
0x0C48, 0x0C48, 0x0C49, 0x0C4A, 0x1048, 0x1448, 0x142A, 0x104A, 0x1068, 0x1068, 0x106A, 0x146A, 0x1089, 0x108A, 0x10A9, 0x14A9, 
0x082C, 0x108C, 0x146B, 0x146D, 0x108C, 0x14AC, 0x14AD, 0x14CD, 0x106F, 0x14AF, 0x14CE, 0x14D0, 0x1091, 0x14F1, 0x10B3, 0x0C96, 
0x2048, 0x1C88, 0x1C2B, 0x1C6B, 0x1CA9, 0x24A8, 0x18AB, 0x20AB, 0x2C88, 0x2C6A, 0x2CA8, 0x2CCB, 0x388A, 0x38C9, 0x40A9, 0x48C9, 
0x1C6D, 0x284D, 0x1CCE, 0x28EE, 0x2490, 0x1CF0, 0x1CB3, 0x1CF3, 0x3C4E, 0x38CE, 0x484F, 0x4C8F, 0x3893, 0x4C94, 0x5892, 0x5CB5, 
0x194A, 0x1D2F, 0x292D, 0x29AB, 0x1912, 0x2512, 0x2532, 0x2592, 0x1935, 0x1D34, 0x2134, 0x2D34, 0x1D75, 0x2595, 0x2D75, 0x2DB5, 
0x1957, 0x1D77, 0x2177, 0x21B8, 0x2996, 0x2998, 0x29D7, 0x29D8, 0x25D9, 0x29F9, 0x31F8, 0x2DF9, 0x3219, 0x321B, 0x323B, 0x2EDC, 
0x450A, 0x456A, 0x4132, 0x3DB3, 0x5549, 0x61A9, 0x5D8D, 0x5D93, 0x4ECA, 0x66CB, 0x5272, 0x6791, 0x76CB, 0x776E, 0x7B73, 0x77D4, 
0x3A19, 0x365B, 0x3A5B, 0x3A7C, 0x5D58, 0x4A5A, 0x6D9B, 0x723C, 0x429B, 0x3F1D, 0x4EDB, 0x533C, 0x76BC, 0x7B7E, 0x7BDA, 0x7FFF
};
