dt=0.01;%sample spacing
s1 = -2:dt:-1; %sampling times over the interval [-2,-1]
s2= 1:dt:3; %sampling times over the interval [1,3]

x1=3*ones(length(s1),1); %samples for first box
x2=4*ones(length(s2),1); %samples for second box
[t,y]= contconv(x1,x2,s1(1),s2(1),dt);
figure(1);
plot(t,y); 