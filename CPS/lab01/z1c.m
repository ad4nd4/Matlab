A = 230; %V
fs = 100; %Hz
t = 0:1/fs:1;

for f = 0:5:300
    y = sin(2*pi*f*t);
    plot(t, y);
    title(['Sygnał sinusoidalny o częstotliwości ', num2str(f), ' Hz']);
    xlabel('Czas [s]');
    ylabel('Amplituda');
    axis([0 1 -1 1]);
    pause(0.5);
end

%freqs = [95;195;295];
freqs = [5;105;205];
%freqs = [95;105];
figure;
for k = 1:3
    subplot(3,1,k);
    for f = freqs(k,:)
        y = sin(2*pi*f*t);
        hold on;
        plot(t, y);
    end
    hold off;
    title(['Porównanie dla częstotliwości: ', num2str(freqs(k,:)), ' Hz']);
    xlabel('Czas [s]');
    ylabel('Amplituda');
    legend(string(freqs(k,:)) + " Hz");
    axis([0 1 -1 1]);
end
