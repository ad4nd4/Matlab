clear all; close all;

axis([0, 80, 0, 70]);
robots = 90;

xy = zeros([robots, 4]);
xy_robot_pov = zeros([robots, 4]);
r = zeros([2, 1]);

sum = 0;

for i=1:90
    xy(i,1) = rand()*80;
    xy(i,2) = rand()*70;

    xy(i, 3) = atand(xy(i,1)/xy(i,2));
    xy(i, 4) = atand(xy(i,1)/(xy(i,2)-70));
    xy(i, 5) = atand((xy(i,1)-80)/(xy(i,2)-70));
    xy(i, 6) = atand((xy(i,1)-80)/xy(i,2));
    
    for j=3:6
        xy_robot_pov(i,j) = xy(i,j) + rand()*6 - 3;
    end

    A = [1, -tand(xy_robot_pov(i,3));
        1, -tand(xy_robot_pov(i,4));
        1, -tand(xy_robot_pov(i,5));
        1, -tand(xy_robot_pov(i,6))];

    b = [0-0*tand(xy_robot_pov(i,3));
        0-70*tand(xy_robot_pov(i,4));
        80-70*tand(xy_robot_pov(i,5));
        80-0*tand(xy_robot_pov(i,6))];

    r = inv(transpose(A)*A) * transpose(A) * b;
    xy_robot_pov(i,1) = r(1,1);
    xy_robot_pov(i,2) = r(2,1);

    d = sqrt((xy(i,1)-xy_robot_pov(i,1))^2 + (xy(i,2)-xy_robot_pov(i,2))^2);

    sum = d+sum;
end

err = sum / robots,

plot(xy(:,1), xy(:,2), 'bx');
hold on;
plot(xy_robot_pov(:,1), xy_robot_pov(:,2), 'rx');