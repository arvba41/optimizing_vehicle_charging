# %% Importing packages
import numpy as np
import pypsa

# %% Creating pypsa network
network = pypsa.Network()

n_bus = 3 # adding three busses

for ii in range(n_bus):
    network.add("Bus", "Bus No. {}".format(ii), v_nom = 20.0)

network.buses
# %% Add three lines in a ring
for ii in range(n_bus):
    network.add("Line", "Line {}".format(ii), 
                bus0 = "Bus No. {}".format(ii),
                bus1 = "Bus No. {}".format((ii + 1) % n_bus),
                x = 0.1,
                r = 0.01,
                )

network.lines
# %% Adding generator at bus 0
network.add("Generator", "Generator 0", 
            bus="Bus No. 0", 
            p_set = 100, 
            control = "PQ",
            )

network.generators
network.generators.p_set
# %% Adding load at bus 1
network.add("Load", "Load 1",
            bus = "Bus No. 1",
            p_set = 100,
            q_set = 100)

network.loads
network.loads.p_set
network.loads.q_set
# %% Newton-Raphson power flow
network.pf()

# %% Results: Newton-Raphson power flow 
network.lines_t.p0 # Active power flow on the lines
network.lines_t.q0 # Reactive power flow on the lines
network.buses_t.v_ang * 180 / np.pi # voltage angles on the busses
network.buses_t.v_mag_pu # voltage magnitude on the busses

# %%
