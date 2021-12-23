clear all;
clc;
T_throughput= 0+ 20.*rand(1,1);
T_delay= 0+ 5.*rand(1,1);
x=[T_throughput T_delay];
x=x';
fis=readfis('Text_FIS');
Text_QoS=evalfis(x,fis)

V_throughput= 0+ 1000.*rand(1,1);
V_delay=0+ 400.*rand(1,1);
V_PDR=0+ 100.*rand(1,1);
V_overhead=0+ 30.*rand(1,1);

x1=[V_throughput V_PDR V_overhead V_delay];
x1 = x1';
fis = readfis('FIS_1');
y = evalfis(x1, fis);
z= [y(2) y(1)];
fis= readfis('Q_FIS');
video_QoS= evalfis(z,fis)

Voi_reachability= 0+ 100.*rand(1,1);
Voi_delay=0+ 400.*rand(1,1);
Voi_PDR=0+ 100.*rand(1,1);
Voi_overhead=0+ 30.*rand(1,1);

x2=[Voi_reachability Voi_PDR Voi_overhead Voi_delay];
x2 = x2';
fis = readfis('FIS_2');
T = evalfis(x2, fis);
V= [ T(2) T(1)];
fis= readfis('Q_FIS');
voice_QoS= evalfis(V,fis)
System_QoS= 0.3*Text_QoS + 0.4*voice_QoS+0.3*video_QoS
