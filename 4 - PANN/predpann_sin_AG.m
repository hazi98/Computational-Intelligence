% PROGRAM TO FORECAST TIME SERIES
% USING POLYNOMIAL ARTIFICIAL NEURAL NETWORK
% Ver 2.0 Release 1
% Date 25/02/2020
% Authors: E. Gomez-Ramirez eduardo.gomez@lasalle.mx
%          
clc
clear all
clf reset

% PARAMETERS

% NUMBER OF DATA FOR THE TRAINING
ntrain = 150;
% NUMBER OF DATA FOR THE TEST
ntest = 150;
% NUMBER OF TRANSITIVE POINTS
ntrans = 50;
% prev_val(1) PREVIOUS VALUES OF THE INPUT
% prev_val(2) PREVIOUS VALUES OF THE OUTPUT
prev_val = [ 0 ; 1 ];
max_prev_val = max ( prev_val );
% TOTAL NUMBER OF POINTS
npoints = ntrain + ntest + ntrans + max_prev_val+1;
% LOAD TIME SERIES 
in_out = [19.4	21.5	21.7	20.8	8.1	4.7	5.2	12.8	11.8	7.9	8.3	12.1	15.4	16.6	17.2	17.8	17.8	9.6	6.3	6.5	8.8	11.4	14.6	19.2	18.8	15.4	5.2	6.8	12.2	10.8	10	12.7	11.7	8.6	11.1	11.7	9.2	6.6	9	15.4	12.1	10.5	7.4	4.7	4.3	7.4	10.4	12.7	12.2	16.3	19.2	15.6	14.8	16	15.6	9.6	9.5	10.5	13.8	17.7	19	19.9	21.4	21.3	18.6	17.7	19.7	16.4	18.1	14.1	15.3	15.6	16.2	18	19	20.2	20.7	22.2	21.7	21.8	19.1	15.4	16.7	19.3	21.6	21.3	21.5	23	18.2	19	18.9	20.4	20.5	20.2	20.2	19.1	16.7	20.3	20.4	21.7	21.1	13.5	11.5	12.7	15.3	17.8	20.5	21.8	22.1	22.6	22.5	23.2	24.6	24.5	21.2	20.6	21.6	21.2	20.1	23.7	24.7	18.5	16.5	19.4	21.5	21.4	21.8	22.4	23.1	23.8	22.8	21.9	25.7	22	21.3	21.8	23	24.8	25.6	25.9	25.6	25.6	25.7	25.8	26	26.4	26.2	26.8	26.6	27.6	28.7	29.3	28.8	27.9	25.3	25.8	25.7	28	27.4	25.9	27.9	28	28.7	28.6	26	25.8	23.4	23.8	27.1	28.3	28.8	27.8	28.4	26	24.5	24.6	24.2	24.5	26.6	26.3	26	26.4	28	28.8	28.8	28.6	28.5	27.5	28.8	28	26.6	26.3	25.8	28.4	29.1	29.4	30.1	29.4	29.6	29.2	28.4	28.1	27.6	27.3	28.5	29.1	27.5	25.6	26.3	26.9	28.3	28.6	29.9	29	29.8	30.3	30.2	30.7	28.1	26.1	27.2	28.5	27.8	28.5	25.3	24.2	24.7	24.1	25.2	25.8	26.3	28.7	29.5	25.9	26	29.5	29.8	30	30.1	29.5	26.4	27	28.3	26.8	25.5	25.3	25	27.2	28.5	28.2	25.4	25.5	25.5	27.3	28.3	28.3	27.3	27.6	28.6	28.9	29.6	28.9	27.5	25.9	26.3	26	26.2	24.5	25.6	25.6	25.2	25.8	25.1	24.9	26.2	26.5	27.2	25.6	22.8	24.5	24.6	25.1	22.4	21.7	21.5	20.6	20.6	18	19.3	22.7	27	28.4	28.7	28.7	28.9	28.2	25	27.3	26.9	26.7	27	26.7	26.2	26.4	26.1	22.1	19.2	13.5	13.4	13.9	16.3	17.9	18.9	16.9	20.3	18.2	10.7	11.9	13.2	18.6	20.7	22.7	19.8	19.7	18.8	21.6	21.9	23.7	12	10.5	17.7	17.2	14	21.6	9	7.8	11.7	10.9	14	19.7	22.1	15.9	15.8	19.1	14.7	12.2	17.5	13.6	6.3	5.7	8.6	11.2	10.8	10	13.9	17.2	10.3	1.3	0.3	2.8	5.7	7.7	12.9	17.7	19.9	20.7];
in_out = transpose(in_out);
% NORMALIZING THE DATA
min_in_out = min( in_out );
max_in_out = max( in_out );
in_out = ( in_out - min_in_out)/(max_in_out - min_in_out);

x = in_out( 1 : npoints , 1 : size(in_out,2) - 1);
y = in_out( 1 : npoints , size(in_out,2) );
 
% TRAINING DATA
%x_train = x( ntrans + 1 : ntrain + ntrans + max_prev_val + 1 );
x_train = 0 ;
y_train = y( ntrans + 1 : ntrain + ntrans + max_prev_val + 1 );

% TESTING DATA
%x_test = x( ntrain + ntrans + max_prev_val + 2 : npoints );
x_test = 0 ;
y_test = y ( ntrain + ntrans + max_prev_val + 2 : npoints );

%PLOT THE TRAINING OUTPUT
%=====================================

plot(y_train);
title('TRAINING DATA');
xlabel('Time');
ylabel('Desired Output');
pausetime = 0.1 ;



max_pow = 1;
ration = 1;
comb_xy = 0 ;

input_bias=1;

tic
[ MZ, y_real ] = gen_MZ(x_train, y_train, prev_val, max_pow, ration, comb_xy, input_bias );
[weights]=mincua(MZ,y_real);
time = toc
n_terms_non_zero= sum(weights~=0)
n_terms_reduced=sum(weights==0)

% COMPUTING THE PANN OUTPUT
y_pann = MZ * weights ;

[ MZ_test, y_real_test ] = gen_MZ ( x_test, y_test, prev_val, max_pow, ration, comb_xy, input_bias );
 
% COMPUTING THE PANN OUTPUT OF THE TEST
y_pann_test=MZ_test*weights;


% PLOTTING RESULTS
%=================================

clf
i_x= 0 : 1 : length ( y_real ) - 1;
subplot(2,1,1),plot(i_x,y_real,i_x,y_pann,'k');
title('Results of the training');
xlabel('time')
ylabel('Real vs. Training')
%pause;

i_x = 0 : 1 : length ( y_real_test ) -1;

subplot(2,1,2),plot(i_x,y_real_test,i_x,y_pann_test,'k');
title('Test');
xlabel('Time')
ylabel('Real vs. Test')

% COMPUTING ERRORS
% TRAINING ERROR
e_training = ( y_real - y_pann )' * ( y_real - y_pann ) / length ( y_real )
% TEST ERROR
e_test = ( y_real_test - y_pann_test )' * ( y_real_test - y_pann_test ) / length ( y_real_test )

[phi]=genphisy(0,prev_val,max_pow,comb_xy,input_bias)
weights'
%phi*num2str(weights)
