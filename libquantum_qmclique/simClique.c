#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <quantum.h>

int main ()
{
  /*
  * v1 v2
  * v1  1(v11)  0(v12)
  * v2  0(v21)  1(v22)
  * u1 =            u11                         ^              ...
  * u1 = [(1 XOR a1 ^ v11) XOR a1] ^ [(1 XOR a2 ^ v21) XOR a2] ... 
  * target = u1 XOR ¬a1 ^ u2 XOR ¬a2 ... 
  */
  quantum_reg reg;
  //int result;

  /* reg = quantum_new_qureg(0, 15);
  *    14      13        12   11 10  9   8   7   6   5   4   3   2  1  0
  *  target controller output u2 u1 u22 u21 u12 u11 v22 v21 v12 v11 a2 a1
  *  |1          1        0    0  0   1   1   1   1   1   0   0   1  0  1>
  * The controller qubit was removed. Tests with a qubit controller to force the output states made 
  * the false states, which are not cliques, be included. If we only meansure the output, 
  * the values are onle the true states in the simulation
  */
  reg = quantum_new_qureg(0, 13);
  /* ¬a ^ b = (1 XOR a ^ b) XOR a = CNOT(TOF(a, b, 1), a)
  *  0 XOR a ^ b = a ^ b = TOF(a, b, 0)
  *    12   11 10  9   8   7   6   5   4   3   2  1  0
  *  output u2 u1 u22 u21 u12 u11 v22 v21 v12 v11 a2 a1
  * |  0     0  0  1   1   1   1   1   0   0   1  0   1>
  */

  //quantum_sigma_x(0, &reg); //if we whish to force input values
  //quantum_sigma_x(1, &reg);

  quantum_sigma_x(2, &reg); // v11 -> 1
  quantum_sigma_x(5, &reg); // v22 -> 1
  
  //If we whish to use a two vertex connected graph
  //quantum_sigma_x(3, &reg); // v12 -> 1
  //quantum_sigma_x(4, &reg); // v21 -> 1  
  
  quantum_sigma_x(6, &reg); // u11 -> 1
  quantum_sigma_x(7, &reg); // u12 -> 1
  quantum_sigma_x(8, &reg); // u21 -> 1
  quantum_sigma_x(9, &reg); // u22 -> 1

  //quantum_print_qureg(reg); \\Print initial state
  
  //Superposition
  quantum_hadamard(0, &reg);
  quantum_hadamard(1, &reg);

  quantum_toffoli(0, 2, 6, &reg);
  quantum_cnot(0, 6, &reg); // u11
  quantum_toffoli(1, 4, 7, &reg);
  quantum_cnot(1, 7, &reg); // u12
  quantum_toffoli(6, 7, 10, &reg); // u1

  quantum_toffoli(0, 3, 8, &reg);
  quantum_cnot(0, 8, &reg); // u21
  quantum_toffoli(1, 5, 9, &reg);
  quantum_cnot(1, 9, &reg); // u22
  quantum_toffoli(8, 9, 11, &reg); // u2

  quantum_sigma_x(0, &reg);
  quantum_sigma_x(1, &reg);
  quantum_cnot(0, 10, &reg); // u1 XOR ¬a1
  quantum_cnot(1, 11, &reg); // u2 XOR ¬a2
  quantum_toffoli(10, 11, 12, &reg); // output (u1 XOR ¬a1) ^ (u2 XOR ¬a2) 

  // swap - If we do use this qubit, the probabilities will be only for true outputs
  //quantum_cnot(12, 13, &reg);
  //quantum_cnot(13, 12, &reg);
  //quantum_cnot(12, 13, &reg); 

  quantum_sigma_x(0, &reg);
  quantum_sigma_x(1, &reg);
  
  quantum_print_qureg(reg);
  
  printf("output |qubit12> %i\n", quantum_bmeasure(12, &reg)); 

  quantum_print_qureg(reg);

  return 0;
}
