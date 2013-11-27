%
% Exports a matrix from MATLAB to C as pointer to a  function
% 
% 
%
function out = export_matrix_to_CH(Matrix,varName)

   FileName = strcat(varName,'.c'); % File name .c
   FileOutput_C = fopen(FileName,'w');   %Open the file .c
   [m,n] = size(Matrix);

   fprintf(FileOutput_C,'%s\r\n','/* CMO exported from MATLAB*/ ');
   fprintf(FileOutput_C,'%s\r\n',' ');

   fprintf(FileOutput_C,'%s\r\n','#include <stdio.h> ');
   fprintf(FileOutput_C,'%s\r\n','#include <math.h> ');
   fprintf(FileOutput_C,'%s\r\n','#include <stdlib.h> ');
   fprintf(FileOutput_C,'%s\r\n',' ');

   fprintf(FileOutput_C,'%s\r\n',strcat('#include "',varName,'.h"'));
   fprintf(FileOutput_C,'%s\r\n',' ');

   fprintf(FileOutput_C,'%s\r\n',strcat('double * _',varName,' = NULL;'));
   fprintf(FileOutput_C,'%s\r\n',' ');

   fprintf(FileOutput_C,'%s\r\n',strcat('void Init_', varName, ' ( )'));
   fprintf(FileOutput_C,'%s\r\n',' {');
   fprintf(FileOutput_C,'%s\r\n',strcat(' _',varName,' = malloc ( ',varName, '_n_rows *' ,32,varName, '_n_cols * sizeof(double) );'));
   fprintf(FileOutput_C,'%s\r\n','  {');
   fprintf(FileOutput_C,'%s\r\n','  int i;');
   fprintf(FileOutput_C,'%s\r\n',strcat('  for (i = 0 ; i < ' ,32,varName, '_n_rows *' ,32,varName, '_n_cols; i++ ) {_',varName,'[i]=0.0;}'));
   fprintf(FileOutput_C,'%s\r\n','  }');
   fprintf(FileOutput_C,'%s\r\n',' }');
   fprintf(FileOutput_C,'%s\r\n',' ');

   fprintf(FileOutput_C,'%s\r\n',strcat('void Done_', varName, ' ( )'));
   fprintf(FileOutput_C,'%s\r\n',' {');
   fprintf(FileOutput_C,'%s\r\n',strcat('  if ( _',varName,' != NULL )'));
   fprintf(FileOutput_C,'%s\r\n',strcat('  free ( _',varName,' );'));
   fprintf(FileOutput_C,'%s\r\n',strcat('_', varName,' = NULL;'));
   fprintf(FileOutput_C,'%s\r\n',' }');

   fprintf(FileOutput_C,'%s\r\n',' ');
   fprintf(FileOutput_C,'%s\r\n',strcat('double * ',32, varName,' ()'));
   fprintf(FileOutput_C,'%s\r\n','{');
   fprintf(FileOutput_C,'%s\r\n',strcat('if ( _',varName,' == NULL )'));
   fprintf(FileOutput_C,'%s\r\n',' {');
   fprintf(FileOutput_C,'%s\r\n',strcat('  _',varName,' = malloc ( ',32,varName, '_n_rows *' ,32,varName, '_n_cols * sizeof(double) );'));
   fprintf(FileOutput_C,'%s\r\n','  {');
   fprintf(FileOutput_C,'%s\r\n','  int i;');
   fprintf(FileOutput_C,'%s\r\n',strcat('  for (i = 0 ; i < ' ,32,varName, '_n_rows *' ,32,varName, '_n_cols; i++ ) {_',varName,'[i]=0.0;}'));
   fprintf(FileOutput_C,'%s\r\n','  }');
   fprintf(FileOutput_C,'%s\r\n',' }');

   fprintf(FileOutput_C,'%s\r\n',' {');

   for j = 0:n-1
     for i = 0:m-1
        fprintf(FileOutput_C,'%s\r\n',strcat('  _',varName,'[',num2str((i)+(j)*m),'] = ',32,num2str(Matrix(i+1,j+1)),';'));
     end
   end

   fprintf(FileOutput_C,'%s\r\n',' }');
   fprintf(FileOutput_C,'%s\r\n',strcat('return _',varName,';'));
   fprintf(FileOutput_C,'%s\r\n','}');
   fclose(FileOutput_C);    %close the file .c

   FileName = strcat(varName,'.h'); % File name .h
   FileOutput_H = fopen(FileName,'w');   %Open the file .h
   fprintf(FileOutput_H,'%s\r\n',strcat('#define ' , 32 ,varName, '_n_rows ',32, num2str(m)));  % 32 ASCII code of space
   fprintf(FileOutput_H,'%s\r\n',strcat('#define ' , 32 ,varName, '_n_cols ',32, num2str(n)));
   fprintf(FileOutput_H,'%s\r\n',strcat('extern double * _', varName,' ;'));
   fprintf(FileOutput_H,'%s\r\n',strcat('extern void Init_', varName, ' ( );'));
   fprintf(FileOutput_H,'%s\r\n',strcat('extern void Done_', varName, ' ( );'));
   fprintf(FileOutput_H,'%s\r\n',strcat('extern double * ',32, varName,' ( );'));

   fclose(FileOutput_H);    %close the file .h

end
