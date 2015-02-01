% goodCodingPractice.
%
%  The following illustrates some of the ideas for good coding,  in
%  terms of compute speed, good memory usage and clean code (elegant!).
%  These are just some of the ideas

%%

% 1.  pre-allocate large arrays
% Bad approach

clear all
tic
for i = 1: 1000
    for j = 1: 1000
        foo(i,j) = i*j;         % some phony operation
    end
end
t1=toc

% use lint to realize you should pre-allocate the array foo

clear all
tic
foo = zeros(1000,1000);
for i = 1: 1000
    for j = 1: 1000
        foo(i,j) = i*j;         % some phony operation
    end
end
t2 = toc

%%

% 2.  avoid memory swapping

% Well, I'm not going to illustrate this.  But if you use too many large
% arrays you will be unable to store everything in memory at one time.  In
% that case, matlab swaps out some of your variable when they aren't in
% use.  In bad cases, matlab must continually swap and thrashes the disk.
% You may notice that a program that ran easily at some size may be
% completely unusable when arrays or data sets are slightly  larger.
% Nothing really to demonstrate here, but pay attention to the number of
% large arrays you have! Don't be overly redundant, creating lots of
% temporary huge arrays. Consider clearing things now and then during long
% codes.

%%

% 3.  exploit matrix computations.  We have beaten this to death and the
% need is not as bad as in previous versions because matlab now compiles
% loops on the first pass.  However it remains a good coding practice to
% use vectorized code.

% example: matrix multiplication
clc
A = rand(100,70);
B = rand(70, 40);

% not good
tic
C = zeros(100,40);
for i = 1: size(A,1)
    for j = 1: size(B,2)
        for k = 1: size(A,2)
            C(i,j) = C(i,j) + A(i,k)*B(k,j);
        end
    end
end
toc

% much better
tic
C2 = A*B;
toc

% check for same results
I=find(C-C2~=0)

%%

% 4.  use logical addressing and find.  Example - zero rows for which
% column 1 is < 0.5

foo = rand(8000,4000);

% not good
tic
for i = 1: size(foo, 1);
    if foo(i,1)< 0.5
        foo(i,:) = 0;
    end
end
toc

% better
foo = rand(8000,4000);
tic
foo(foo(:,1)<0.5) = 0;
toc

%%

% 5. Sometimes, results are surprising. Consider the task of setting all
% odd entries of a matrix to zero.
clc

%classic loop
tic
v=rand(1,1e8);
n=length(v);
for k=1:2:n
    v(k)=0;
end
toc

%vector index
tic
v=rand(1,1e8);
n=length(v);
v(1:2:n)=0;
toc

%boolean / logical
tic
v=rand(1,1e8);
n=length(v);
mask=false(n,1);
mask(1:2:n)=true;
v(mask)=0;
toc

%I find the classic way best here, due to overhead associated with vector
%indexing. If you cut the length of v way down, results can be different.

%further differences in results depend upon the task.

%classic loop
tiv=rand(1,1e8);
for k=1:n
    if isnan(v(k))
        v(k)=0
    end
end
toc

%vector index
tic
v=rand(1,1e8);
ind=find(isnan(v));
v(ind)=0;
toc

%boolean / logical
tic
v=rand(1,1e8);
mask=isnan(v);
v(mask)=0;
toc



%%

% 6. Matrix solution. Au = b is often something we wish to solve for u. We
% know that u = A^(-1)b, if A is a regular matrix.

%slow way
tic
n = 2e3;
A = rand (n,n);
b = rand (n ,1);
u = inv(A)*b;
toc;

%fast way
tic
n = 2e3;
A = rand (n,n);
b = rand (n ,1);
u = A\b;
toc

%%

% 7. Sparse matrices. In many applications, we end up with a huge matrix,
% with most elements equal to zero. For example, in finite-difference
% approximations to differential equations. In these cases, the diagonal
% and a few elements to each side will be nonzero. Sparse matrices in
% matlab save a TON of memory.

C=speye(5000);
C2=eye(5000);
whos C C2

figure
spy(C,'o')
axis([1 10 1 10])

% Note: it is also faster to do stuff with sparse matrices!

%slow
tic
n = 1e4;
h = 1/(n +1);
A = zeros (n,n);
A(1 ,1) = 2;
A(1 ,2) = -1;
for i=2:n -1
A(i,i -1) = -1;
A(i,i ) = 2;
A(i,i+1) = -1;
end
A(n,n -1) = -1;
A(n,n) = 2;
A = A / h^2;
b = ones (n ,1);
u = A\b;
toc

%fast
tic
n = 1e4;
h = 1/(n +1);
e = ones (n ,1);
A2 = spdiags ([-e 2*e -e] ,...
[-1 0 1] ,...
n, n );
A2 = A2 / h^2;
b = ones (n ,1);
u2 = A2\b;
toc

%%
% 8. real functions.

tic
for i=1:1e6;
    ans=sqrt(i);
end
toc

tic
for i=1:1e6;
    ans=realsqrt(i);
end
toc

%%
% 9. Short circuit logical operators. This doesn't seem to save as much
% time as it should, given how they are supposed to work...  ??

tic
for i=1:1e7
    if mod(i,5)==0 & mod(i,2)==0
        ans=sqrt(i);
    end
end
toc

tic
for i=1:1e7
    if mod(i,5)==0 && mod(i,2)==0
        ans=sqrt(i);
    end
end
toc



