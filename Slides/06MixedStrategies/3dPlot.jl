## For example with 3 pure strategies in slides:

using PlotlyJS, DataFrames, RDatasets, Colors, Distributions, LinearAlgebra

function exp_util()
    eu_x = Vector[
        [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
        [0.4, 0.6, 0.8, 1.0, 1.2, 1.4],
        [0.8, 1.0, 1.2, 1.4, 1.6, 1.8],
        [1.2, 1.4, 1.6, 1.8, 2.0, 2.2],
        [1.6, 1.8, 2.0, 2.2, 2.4, 2.6],
        [2.0, 2.2, 2.4, 2.6, 2.8, 3.0],
    ]

    eu_y = Vector[
        [2.0, 1.8, 1.6, 1.4, 1.2, 1.0],
        [1.6, 1.4, 1.2, 1.0, 0.8, 0.6],
        [1.2, 1.0, 0.8, 0.6, 0.4, 0.2],
        [0.8, 0.6, 0.4, 0.2, 0.0, -0.2],
        [0.4, 0.2, 0.0, -0.2, -0.4, -0.6],
        [0.0, -0.2, -0.4, -0.6, -0.8, -1.0],
    ]
    trace1 = surface(z=eu_x, colorscale="Viridis")
    trace2 = surface(z=eu_y, showscale=false, opacity=0.8, color="blue")
    layout = Layout(title="Expected Utility of Player 2's pure strategies",
    )
    plot([trace1, trace2],layout)
end
exp_util()

