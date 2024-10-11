import math


def temp_szum(gt, szum, t1, t2):
    return gt + 10*math.log(t1 + t1*t2/(szum-t2),10)

def free_space_loss(opoznienie, czestotliwosc):
    C = 299792458  # predkosc swiatla
    f = czestotliwosc * 1000
    t_s = opoznienie*0.001
    print(t_s)
    d_m = t_s * C
    d_km = d_m * 0.001
    print(f"Distance: {d_km}\nfreq: {f}")
    return 32.4 + 20*math.log(d_km, 10) + 20*math.log(f, 10)

def tel_kom_prawdopodobienstwo(moc):
    param = pow(10, moc/10)
    return math.exp(-param)

print(temp_szum(32, 5185, 150, 500))
print(free_space_loss(29, 13))
print(tel_kom_prawdopodobienstwo(8.6))