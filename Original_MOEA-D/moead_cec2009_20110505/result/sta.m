Problems = ['UF1        ';
            'UF2        ';
            'UF3        ';
            'UF4        ';
            'UF5        ';
            'UF6        ';
            'UF7        ';
            'UF8        ';
            'UF9        ';
            'UF10       ';
            'R2_DTLZ2_M5';
            'R3_DTLZ3_M5';
            'WFG1_M5    '];
objs    = [2 2 2 2 2 2 2 3 3 3 5 5 5]; 
points  = [100 100 100 100 100 100 100 150 150 150 800 800 800];

gd = zeros(34,13);
for p=1:13
    fname = sprintf('../moead_cpp/POF0/%s.dat', deblank(Problems(p,:)));
    PF = load(fname);
    for r=1:30
        fname   = sprintf('../moead_cpp/POF/PF_%s_%d.dat', deblank(Problems(p,:)), r);
        PF0     = load(fname);
        ind     = cec09filter(PF0', points(p));
        PF1     = PF0(ind, :);
        gd(r,p) = IGD(PF', PF1');
    end
end
gd(31,:) = mean(gd(1:30,:));
gd(32,:) = std(gd(1:30,:));
gd(33,:) = min(gd(1:30,:));
gd(34,:) = max(gd(1:30,:));

save('tabs.txt', 'gd', '-ascii', '-double');
