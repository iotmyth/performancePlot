A=rand(3);
disp(A);
A([2 3],2)=NaN;
disp(A);
A(isnan(A))=0;