### A Pluto.jl notebook ###
# v0.11.2

using Markdown
using InteractiveUtils

# ╔═╡ f2be1bf2-d600-11ea-16c5-1fbd2c1198da


# ╔═╡ f2a66962-d600-11ea-329f-47505aca7cba


# ╔═╡ f28e14d4-d600-11ea-1746-434d9c2c96b1


# ╔═╡ f275f2d2-d600-11ea-2bb4-5719b270c762


# ╔═╡ f25e8ebc-d600-11ea-3275-9984b3da317c


# ╔═╡ f242f90e-d600-11ea-3901-236f8b4ffcc9


# ╔═╡ f22a95ee-d600-11ea-3b94-d769f3a950c4


# ╔═╡ f20eeeca-d600-11ea-1257-599e2734515b


# ╔═╡ 010595c6-d60f-11ea-24ea-3d5c5c38b09f
md"Time taken - 17.197210 seconds (475.75 k allocations: 24.996 MiB)"

# ╔═╡ bb840258-d61b-11ea-07f9-adc14a28f251
layout=(args...)->spring_layout(args...; C=20)

# ╔═╡ 1561d4a6-d60f-11ea-2abf-e32f78aedbf0
md"## Large number of followers"

# ╔═╡ d121596e-d600-11ea-0de4-f7bf58e224cf
begin
	using LightGraphs
	using GraphIO
	using GraphPlot
	using Colors
	using Cairo, Compose

end

# ╔═╡ f2f1db68-d600-11ea-0b7f-997869f98e35
graph = loadgraph("/home/subhaditya/Desktop/Datasets/graph/celebrities_profiles.txt", EdgeListFormat())

# ╔═╡ 4c15fd14-d60e-11ea-362e-a158e1833164
nodefillc = distinguishable_colors(nv(graph), colorant"red")

# ╔═╡ 00e68dc6-d61b-11ea-39ea-aff626d9e6f5
edgelabel = [1:LightGraphs.ne(graph)]

# ╔═╡ 3827978a-d61b-11ea-1768-9bfdad6c3949
nodelabel = [1:nv(graph)]

# ╔═╡ f30685da-d61a-11ea-14cb-61e7aef3cad3
nodesize = [LightGraphs.outdegree(graph, v) for v in LightGraphs.vertices(graph)]

# ╔═╡ b16d2208-d617-11ea-3809-5f2c1ef0d25b
gp = gplot(graph, layout = layout, nodesize=nodesize,  nodefillc=nodefillc, edgestrokec = colorant"red" )

# ╔═╡ f2d6b46e-d600-11ea-1661-b1029fa8141c
draw(SVG("celebri.svg", 60cm, 60cm), gp)

# ╔═╡ Cell order:
# ╠═f2be1bf2-d600-11ea-16c5-1fbd2c1198da
# ╠═f2a66962-d600-11ea-329f-47505aca7cba
# ╠═f28e14d4-d600-11ea-1746-434d9c2c96b1
# ╠═f275f2d2-d600-11ea-2bb4-5719b270c762
# ╠═f25e8ebc-d600-11ea-3275-9984b3da317c
# ╠═f242f90e-d600-11ea-3901-236f8b4ffcc9
# ╠═f22a95ee-d600-11ea-3b94-d769f3a950c4
# ╠═f20eeeca-d600-11ea-1257-599e2734515b
# ╟─010595c6-d60f-11ea-24ea-3d5c5c38b09f
# ╠═f2d6b46e-d600-11ea-1661-b1029fa8141c
# ╠═b16d2208-d617-11ea-3809-5f2c1ef0d25b
# ╠═4c15fd14-d60e-11ea-362e-a158e1833164
# ╠═bb840258-d61b-11ea-07f9-adc14a28f251
# ╠═00e68dc6-d61b-11ea-39ea-aff626d9e6f5
# ╠═3827978a-d61b-11ea-1768-9bfdad6c3949
# ╠═f30685da-d61a-11ea-14cb-61e7aef3cad3
# ╠═f2f1db68-d600-11ea-0b7f-997869f98e35
# ╠═1561d4a6-d60f-11ea-2abf-e32f78aedbf0
# ╠═d121596e-d600-11ea-0de4-f7bf58e224cf
