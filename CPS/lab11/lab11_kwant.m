function y = lab11_kwant(x,b)
      xlef = x(:,1);   %  rozdzielamy na kanal lewy i prawy
      xrig = x(:,2);
      xMinL = min(xlef);
      xMaxL = max(xlef);
      xMinR = min(xrig);
      xMaxR = max(xrig);
      
      x_zakresL=xMaxL-xMinL; % minimum, maksimum, zakres
      x_zakresR=xMaxR-xMinR;
      
      Nb=b; Nq=2^Nb; % liczba bitów, liczba przedziałów kwantowania
      dx=x_zakresL/Nq; % szerokość przedziału kwantowania
      xql=dx*round(xlef/dx);
      
      dx=x_zakresR/Nq;
      xqr=dx*round(xrig/dx);
      
      y = horzcat(xql,xqr); % funkcja zwraca sygnal stereo
   end