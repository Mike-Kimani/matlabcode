clc;
theta_2 = [40 ,45, 50, 55, 60];
theta4 = [70, 76, 83, 91, 100];
ci = cosd(theta_2);
co = cosd(theta4);
diff = cosd(theta_2 - theta4);
ci2 = cosd(theta_2).^2;
co2 = cosd(theta4).^2;
e1 = [sum(co2), -sum(ci.*co), sum(co);
      sum(co.*ci), -sum(ci2), sum(ci);
      sum(co), -sum(ci), length(theta_2)];
e2 = [sum(co.*diff); sum(ci.*diff); sum(diff)];
ratios = linsolve(e1,e2);
%disp(ratios)

K1 = ratios(1);
K2 = ratios(2);
K3 = ratios(3);

fprintf('K1 = %.15g\n',K1);
fprintf('K2 = %.15g\n',K2);
fprintf('K3 = %.15g\n',K3);

fixed = 180;

crank_length = fixed /K1;
follower_length = fixed / K2;
coupler_length = sqrt((crank_length*crank_length)+(follower_length*follower_length)+(fixed*fixed)-(K3*2*crank_length*follower_length));

fprintf('crank_length = %.15g\n',crank_length);
fprintf('follower_length = %.15g\n',follower_length);
fprintf('coupler_length = %.15g\n',coupler_length);

%transmission angles
theta_i = 40:1:60;
transmission_angle = acosd(((coupler_length^2)+(follower_length^2)-(crank_length^2)-(fixed^2)+(2*crank_length*fixed*cosd(theta_i)))/(2*coupler_length*follower_length));
disp('TABLE OF ANGULAR INPUT AND TRANSMISSION ANGLES')
disp('   input    transmission   ')
disp([theta_i',transmission_angle'])
figure(1)
plot(theta_i,transmission_angle),xlabel('\theta(degrees)'),ylabel('transmission angle'),title('transmission angle vs \theta'),grid on
