% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert h�sten 2006 av Jostein Bakkeheim
% Oppdatert h�sten 2008 av Arnfinn Aas Eielsen
% Oppdatert h�sten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring

clear all;
close all;
clc;

%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;

%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]

%%%%%%%%%%% From 1.4
V_s = 7;
K_f = -(g*(m_c*l_c-2*m_p*l_h))/(V_s*l_h);
 
%%%%%%%%%%% From 2.1

L_1 = K_f*l_p; 
L_2 = g*(m_c*l_c-2*m_p*l_h);
L_3 = K_f*l_h;
L_4 = -L_3;

J_p = 2*m_p*(l_p)^2;
J_e = m_c*(l_c)^2 + 2*m_p*(l_h)^2;
J_y = m_c*(l_c)^2 + 2*m_p*((l_h)^2+(l_p)^2);

K_1 = L_1/J_p;
K_2 = L_3/J_e;
K_3 = L_4*V_s/J_y;

%%%%%%%%%%%% 3.2

A = [0 1 0; 0 0 0; 0 0 0];
B = [0 0; 0 K_1; K_2 0];
Q = [91.2 0 0; 0 50 0; 0 0 100];
R = [1 0; 0 1];
C = [1 0 0; 0 0 1];
K = lqr(A,B,Q,R);
P = inv(C*inv(-A+B*K)*B);

