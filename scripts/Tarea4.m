%% Gráfica del campo de desplazamientos para una barra prismática bajo su mismo peso
clear all;
% Datos del problema 
zOrg = 0; % Origen z-dir
L = 0.1; % Longitud en las direcciones y, z
g = 9.81; % Aceleración de la gravedad

% Constantes de elasticidad para el Alumino
nu = 0.35; % Coeficiente de Poisson
E = 70e9; % Módulo de Young [Pa]
rho = 2699; % Densidad del material [kg/m^3]

% Genereación del mallado 2D
y = -L:0.005:L;
z = zOrg:0.005:L;
[Y, Z] = meshgrid(y, z);

% Cálculo del campo de desplazamientos en el plano YZ
vy = -(nu*rho*g/E)*Y.*Z; % Componente u del campo de desplazamientos
wz = (rho*g/(2*E))*(Z.^2 + nu*Y.^2 - L^2); % Componente w del campo de desplazamientos para x = 0

% Gráfica del campo de desplazamientos
quiver(Y, Z, vy, wz, "Color", "b")
title("Campo de desplazamientos para una barra prismática bajo su mismo peso")
xlabel('$y$', 'Interpreter','latex', 'FontSize', 14)
ylabel('$z$', 'Interpreter', 'latex', 'FontSize', 14)
xlim([min(Y(:)) max(Y(:))]);
ylim([min(Z(:)) max(Z(:))]);

set(titleHandle, 'HorizontalAlignment', 'center');
saveas(gcf, "/home/marcoslm/Projects/University/2024-2/dmd/Tareas/T4/img/campodesplazamientos", 'pdf')