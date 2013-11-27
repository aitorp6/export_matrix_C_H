export_matrix_C_H
=================

Exports a matrix from MATLAB to C as pointer to a function. Exports to file, .H and .C

How to use:
-----------

export_matrix_C_H(matlab_matrix_name,'desired_name_in_C') 

```
>> A = [
        1,2,3;
        4,5,6;
        7,8,9
       ];
     
>> A

A =

     1     2     3
     4     5     6
     7     8     9

export_matrix_C_H(A,'A')  

```


