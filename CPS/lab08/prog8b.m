
% Prog. 8b - filtry specjalne 
clear all; close all;

fpr = 8000;
Nx = 8000;
dt=1/fpr; t = dt*(0:Nx-1);

iWHAT = 2;
if( iWHAT == 1 )   % cos()
    x = cos( 2*pi*10*t );else      % AM-FM
    AM = 10*(1+0.5*sin(2*pi*2*t));
    fc=2000; FM = 1000*sin( 2*pi*5*t );
    x = AM .* cos( 2*pi*(fc*t + cumsum(FM)*dt ) );
end    

figure;
plot(t,x); title('x(t)'); pause

% Filtr w dziedzinie częstotliwości 
if(1)
    X = fft(x);
    H = [ 0, -j*ones(1,Nx/2-1), 0, j*ones(1,Nx/2-1) ];
  % H = [ j*2*pi*(fpr/Nx)*(0:Nx-1) ]; % przykład dla różniczkującego
    Y = H .* X;
    y = ifft(Y);
    y = x + j*y;  % TYLKO dla Hilberta !!!
end
if(0)
   y = filbert(x);
end    

figure;
plot(t,real(y),'r-',t,imag(y),'b-'); grid; title('RED x(t) BLUE y(t)'); pause

% Tylko dla sygnału AM-FM

if( iWHAT > 1 )

   AM_est = abs( y );
   dfi = angle( y(2:end) .* conj(y(1:end-1)) );
   FM_est = (1/(2*pi)) * dfi / dt - fc;

   figure;
   subplot(211); plot( t, AM, 'r-', t, AM_est, 'b-' ); title('AM');
   subplot(212); plot( t, FM, 'r-', t(2:end), FM_est, 'b-' ); title('FM');
   pause

end