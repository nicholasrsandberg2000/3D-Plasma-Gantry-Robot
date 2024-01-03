clear all; close all; clc;

% Step Size (Pixels)
dx = 23;
xstep = dx/2; % half step of dx (referenced in while loop)

% Coordinates (Pixels), origin at (0,0)
xgo = 0; % x global origin
ygo = 0; % y global origin
xgl = 760; % x global limit
ygl = 480; % y global limit
xbo = 100; % x boundary origin (relative to global domain)
ybo = 50; % y boundary origin (relative to global domain)
xbl = 333; % x boundary limit (relative to global domain)
ybl = 140; % y boundary limit (relative to global domain)

n = xbl-xbo; % x length of boundary box
q = round((n)/dx); % number of iterations 
o = 4; % number of target coordinates per iteration
r = o*q; % length of tool path coordinates array

% Start toolpath at lower left hand corner of boundary box
% tx = tool path x coordinates, ty = tool path y coordinates
tx(1) = xbo; 
ty(1) = ybo; 

i = 2;
k = 1;
while i < r+1
    while k < o+1 & i < r+1  
        tx(i) = tx(i-1);
        ty(i) = ybl;
        i = i+1;
        k=k+1;
        tx(i) = tx(i-1)+xstep;
        ty(i) = ty(i-1);
        i = i+1;
        k=k+1;
        tx(i) = tx(i-1);
        ty(i) = ybo;
        i = i+1;
        k=k+1;
        tx(i) = tx(i-1)+xstep;
        ty(i) = ty(i-1);
        i = i+1;
        k=k+1;
    end
    k=0;
end

% end of tool path coordinates in top right corner
tx(i) = tx(i-1); 
ty(i) = ybl;

% Return to origin at end
% tx(i+1) = xgo;
% ty(i+1) = ygo; 

% Boundary box coordinates for visual representation
bx = [xbo,xbo,xbl,xbl,xbo];
by = [ybo,ybl,ybl,ybo,ybo];

% visual representation of tool path with boundary box
plot(tx,ty,'b','Linewidth',2)
hold on
plot(bx,by,'--r','Linewidth',1)
xlim([xgo, xgl])
ylim([ygo, ygl])
title('Tool Path')
xlabel('x distance (Pixels)')
ylabel('y distance (Pixels)')

