clear all;
close all;

size_X = 80; size_Y = 100;
robots = 120;

xy = zeros([robots, 6]);
xy_robot_pov = zeros([robots, 6]);
r = zeros([2, 1]);

sum = 0;

for i=1:120
    xy(i,1) = rand()*size_X;
    xy(i,2) = rand()*size_Y;

    xy(i, 3) = atan(xy(i,1)/xy(i,2));
    xy(i, 4) = atan(xy(i,1)/(xy(i,2)-size_Y));
    xy(i, 5) = atan((xy(i,1)-size_X)/(xy(i,2)-size_Y));
    xy(i, 6) = atan((xy(i,1)-size_X)/xy(i,2));
    
    for j=3:6
        xy_robot_pov(i,j) = xy(i,j) + rand()*6 - 3;
    end

    A = [1, -tan(xy_robot_pov(i,3));
        1, -tan(xy_robot_pov(i,4));
        1, -tan(xy_robot_pov(i,5));
        1, -tan(xy_robot_pov(i,6))];

    b = [0-0*tan(xy_robot_pov(i,3));
        0-size_Y*tan(xy_robot_pov(i,4));
        size_X-size_Y*tan(xy_robot_pov(i,5));
        size_X-0*tan(xy_robot_pov(i,6))];

    r = (transpose(A) * A) \ (transpose(A) * b);
    xy_robot_pov(i,1) = r(1,1);
    xy_robot_pov(i,2) = r(2,1);

    d = sqrt((xy(i,1)-xy_robot_pov(i,1))^2 + (xy(i,2)-xy_robot_pov(i,2))^2);

    sum = d+sum;
end

err = sum / robots,

plot(xy(:,1), xy(:,2), 'bx');
hold on;
plot(xy_robot_pov(:,1), xy_robot_pov(:,2), 'rx');
