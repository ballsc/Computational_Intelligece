%% Function to solve VLSI Circuit Placement

% Format Initial Values
temp = 10; M = 10; alpha = .9; beta = .9;
time = 0; max_time = 28;

cells_init = [1, 1; 2, 1; 3, 1; 4, 1;
              1, 2; 2, 2; 3, 2; 4, 2;];

cells = cells_init;

N = format_n(cells);

% Find Initial Wirelength
wirelength = calc_wirelength(N);

disp(wirelength)

% Loop for remainder
while time <= max_time
    % swap cells
    cells = swap(1, 8, cells_init);
    
    N = format_n(cells);

    new_wirelength = calc_wirelength(N);

    delta_h = new_wirelength - wirelength;

    % New best wirelength
    if delta_h < 0
        best = new_wirelength;
        wirelength = new_wirelength;
    end
    
    if rand() < exp(-delta_h/temp), wirelength = new_wirelength; end

    M = M * beta;
    temp = temp * alpha;
    time = time + 1;
end

%% Helpers
function cells = swap(C1, C2, cells_init)

    cells_temp1 = cells_init(C1, :);
    cells_temp2 = cells_init(C2, :);

    cells_init(C1, :) = cells_temp2;
    cells_init(C2, :) = cells_temp1;

    cells = cells_init;
end

function wirelength = calc_wirelength(N)
    wirelength = 0;

    for i = 1:10
        x_max = max(N{i}(:, 1));
        x_min = min(N{i}(:, 1));
        y_max = max(N{i}(:, 2));
        y_min = min(N{i}(:, 2));
    
        wirelength = wirelength + (x_max - x_min) + (y_max - y_min);
    end
end

function N = format_n(cells)
    N1 = [cells(1, :); cells(3, :); cells(4, :)];
    N2 = [cells(6, :); cells(7, :)];
    N3 = [cells(2, :); cells(5, :)];
    N4 = [cells(3, :); cells(6, :)];
    N5 = [cells(4, :); cells(7, :)];
    N6 = [cells(1, :); cells(7, :)];
    N7 = [cells(2, :); cells(3, :); cells(5, :)];
    N8 = [cells(2, :); cells(7, :)];
    N9 = [cells(5, :); cells(8, :)];
    N10= [cells(4, :); cells(5, :)];
    N = {N1, N2, N3, N4, N5, N6, N7, N8, N9, N10};
end