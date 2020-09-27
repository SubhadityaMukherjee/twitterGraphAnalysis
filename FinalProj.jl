### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ a924e8d2-00a7-11eb-1da9-7b63cefd7e7f
begin
	using Markdown
	using InteractiveUtils
	using LightGraphs
	using GraphIO
	using GraphPlot
	using Colors
	using Cairo, Compose
	using Plots
	using DelimitedFiles
	using Query
	using DataFrames
	using PyCall
	using Clustering
	using Pipe
	using GraphDataFrameBridge
	using MLJ
end

# ╔═╡ 7ed89550-00a8-11eb-23ce-171451ed0034
md"# Running everything in Julia"

# ╔═╡ c298a33a-00a7-11eb-26b1-4b92fd9c7a1a
layout = (args...) -> spring_layout(args...; C = 20)


# ╔═╡ c2720644-00a7-11eb-3109-b1958120835b
md"# EGO NETWORK for a subset of first 10k nodes (all same connection)"

# ╔═╡ c258b194-00a7-11eb-099e-432a401b6455
edge_network = loadgraph(
    "/home/subhaditya/Desktop/Datasets/graph/twitter_ego_part.net",
    EdgeListFormat(),
)


# ╔═╡ 334d76cc-00a9-11eb-0326-6d811b47fec9
md"## Label the network "

# ╔═╡ c242b3da-00a7-11eb-03d1-992cd42570a3
edgelabel = [1:LightGraphs.ne(edge_network)]

# ╔═╡ 13827d56-00a9-11eb-11a7-db2cba0e4df9
nodelabel = [1:nv(edge_network)]

# ╔═╡ 13830d5c-00a9-11eb-3450-0b0fd817fb5f
nodesize =
    [LightGraphs.outdegree(edge_network, v) for v in LightGraphs.vertices(edge_network)]

# ╔═╡ dbaaf6ac-00a9-11eb-38d2-db79aff72fea
md"## Graph coloring"

# ╔═╡ 13839394-00a9-11eb-21ed-d3665e3a7ddd
nodefillc = distinguishable_colors(nv(edge_network), colorant"blue")

# ╔═╡ c22d149e-00a7-11eb-13b9-3d4dd02afaf7
"""
gp = gplot(
    edge_network,
    layout = layout,
    nodesize = nodesize,
	nodefillc = nodefillc,
	nodelabeldist=1.8,
	nodelabelangleoffset=π/4)
"""

# ╔═╡ 27856782-00a9-11eb-03bb-09334ef6503b
#draw(SVG("celebri.svg", 60cm, 60cm),

# ╔═╡ c2136576-00a7-11eb-05f5-8f1a400c0807
md"# Features of the network"

# ╔═╡ c1f9cab2-00a7-11eb-1290-197d227f501d
md"- ne = 10000, nv = 10001"

# ╔═╡ c1e1a7ca-00a7-11eb-31ce-ef107afd65e1
ne(edge_network)

# ╔═╡ 4e1320b0-00a9-11eb-2238-6341050b81d3
nv(edge_network)

# ╔═╡ 4e136a5c-00a9-11eb-21c9-21a912560f06
has_self_loops(edge_network)

# ╔═╡ 4e18c64e-00a9-11eb-3ef0-fb9c16fadaeb
md"## Adjacency"

# ╔═╡ 4e264596-00a9-11eb-2a6c-f5d97ef7f3fc
adjm = adjacency_matrix(edge_network)

# ╔═╡ 4e323bb2-00a9-11eb-30b0-fb2ce344922f
verts = vertices(edge_network)

# ╔═╡ 4e3e77c4-00a9-11eb-11b0-c573ba931ddf
adjm[1,:]

# ╔═╡ 6eb3eb74-00a9-11eb-1644-b99954e0e396
md"## Clustering"

# ╔═╡ c1cbee24-00a7-11eb-10a5-19671ebfbba0
km = kmeans(adjm, 5)

# ╔═╡ 6e2c9b4c-00a9-11eb-2143-05b9d5f10d34
counts(km.assignments)

# ╔═╡ 97387a7e-00a9-11eb-02bf-c32f6cf6a44c
md"# Entire EGO NETWORK"

# ╔═╡ 971f95e2-00a9-11eb-3b77-01a355e57e36
edge_network2 = loadgraph(
    "/home/subhaditya/Desktop/Datasets/graph/twitter_ego_shuffled.net",
    EdgeListFormat(),
)

# ╔═╡ 1b68bcf0-00aa-11eb-07eb-7bcb884131b6
md"## Label the Network"

# ╔═╡ 1b6aac3e-00aa-11eb-25db-437b5ab88970
edgelabel2 = [1:LightGraphs.ne(edge_network2)]

# ╔═╡ 1b6fffd8-00aa-11eb-0c74-15018b32fb67
nodelabel2 = [1:nv(edge_network2)]

# ╔═╡ 1b809bc2-00aa-11eb-08a8-556c4be98b65
nodesize2 =
    [LightGraphs.outdegree(edge_network2, v) for v in LightGraphs.vertices(edge_network2)]

# ╔═╡ 1b94228c-00aa-11eb-1912-198c4db7489f
md"## Color the network"

# ╔═╡ 1ba9491e-00aa-11eb-1de4-c7ef7734201d
nodefillc2 = distinguishable_colors(nv(edge_network2), colorant"blue")

# ╔═╡ 970b8410-00a9-11eb-2e64-69b92a4aa6a1
md"## Features"

# ╔═╡ 96f3ce42-00a9-11eb-3a58-e72738661bfa
ne(edge_network2)

# ╔═╡ c03ba6ac-00aa-11eb-3753-c97eec7f6037
nv(edge_network2)

# ╔═╡ c03d7cb6-00aa-11eb-174f-69706ec67bc7
has_self_loops(edge_network2)

# ╔═╡ c03f892a-00aa-11eb-2841-75766a3344fb
md"## Adjacency"

# ╔═╡ c04ee316-00aa-11eb-1bcb-3dbe6195aced
adjm2 = adjacency_matrix(edge_network2)

# ╔═╡ c061e3aa-00aa-11eb-22e0-65a09cb4f612
verts2 = vertices(edge_network2)

# ╔═╡ c077ca42-00aa-11eb-1278-e1dda526d7d3
adjm2[1,:]

# ╔═╡ c090fb54-00aa-11eb-2d9c-1529483e9445
md"## Clustering"

# ╔═╡ c0a6f8da-00aa-11eb-0e3a-35db0db694ad
kmeans(adjm2, 5)

# ╔═╡ c1662c44-00a7-11eb-25e9-efc6fe2a397a
md"# Celebrities"

# ╔═╡ 54609382-00ac-11eb-1da3-bbfde46e8c8e
md"## Get data"

# ╔═╡ 5462c056-00ac-11eb-27f6-6b6772dc928f
data_cels = readdlm("/home/subhaditya/Desktop/Datasets/graph/celebrities_profiles.txt", '\t')

# ╔═╡ 5468a568-00ac-11eb-19c4-718f77a122ea
data_cels[1:4, :]

# ╔═╡ 547aed22-00ac-11eb-1dd4-35c35ef49c12
cols = ["no","x1","x2","x3","x4","xn", "country", "x5", "x6", "x7", "Designation","x8","x9","profile", "x10", "x11","x12","x13", "x14","name","x15","time","timezone","x16","x17", "x18"]

# ╔═╡ 548d9668-00ac-11eb-3f61-0d2323624792
data_table = DataFrame(data_cels)

# ╔═╡ 54a0b494-00ac-11eb-394d-29bdd91c9c68
names!(data_table, Symbol.(cols))

# ╔═╡ c14d034a-00a7-11eb-3ccc-6324222ab747
groupby(select(data_table, [:no, :country]), [:country])

# ╔═╡ 4258ce06-00ad-11eb-0a7d-757963205b3b
md"## Get countries"

# ╔═╡ c134c80c-00a7-11eb-1278-85c17d8b1064
countries = unique(data_table.country)

# ╔═╡ 78fa09c0-00b4-11eb-395b-250cca2edf33
dict_countries = Dict(countries[x]=>x for x in 1:length(countries))

# ╔═╡ b5a9d100-00b4-11eb-0002-117348c85407
returnid(x) = dict_countries[x]

# ╔═╡ 8d75f5ce-00b4-11eb-294b-8f6f23cfee9a
data_table["country"] = returnid.(data_table["country"])

# ╔═╡ c0c345a6-00a7-11eb-2156-9ff8e85ab512
mg = MetaGraph(data_table, :country, :no)

# ╔═╡ 3631231e-00b5-11eb-0732-23c8a3803d55
sort(counts(data_table["country"]),rev = true)

# ╔═╡ c0aa817e-00a7-11eb-08b1-9b07e7bad09c
gp = gplot(
    mg,
    layout = layout,
	nodelabeldist=1.8,
	nodelabelangleoffset=π/4)


# ╔═╡ c099995e-00a7-11eb-1ebe-430425edca80
draw(SVG("countries.svg", 60cm, 60cm),gp)

# ╔═╡ c2af929e-00b5-11eb-3415-c3146663e6d8
md"## Designation"

# ╔═╡ c0829c86-00a7-11eb-1fd8-4dcc7a07a50a
designation = unique(data_table.Designation)

# ╔═╡ e61947b6-00b5-11eb-2bdc-7973d028b67c
dict_designation = Dict(designation[x]=>x for x in 1:length(designation))

# ╔═╡ e61d3e28-00b5-11eb-397b-45a3ffa64d58
returnid2(x) = dict_designation[x]

# ╔═╡ e62c4dca-00b5-11eb-024e-1bff841e4a81
data_table["Designation"] = returnid2.(data_table["Designation"])

# ╔═╡ e65fc2c2-00b5-11eb-070a-29ee7397c9e3
mg2 = MetaGraph(data_table, :Designation, :no)

# ╔═╡ e68396fc-00b5-11eb-2d92-87c305bd58c8
sort(counts(data_table["Designation"]),rev = true)

# ╔═╡ e6ace75a-00b5-11eb-1111-a716200eec2f
gp2 = gplot(
    mg2,
    layout = layout,
	nodelabeldist=1.8,
	nodelabelangleoffset=π/4)

# ╔═╡ e6d5fc08-00b5-11eb-17f2-f53cc1d9a4d8
draw(SVG("designation.svg", 60cm, 60cm),gp2)

# ╔═╡ c06c357c-00a7-11eb-3a84-7bb0f0893e54


# ╔═╡ c064eb6e-00a7-11eb-1ed9-539df755a5ec


# ╔═╡ c011ea54-00a7-11eb-293e-c5a918f7445b


# ╔═╡ bfe9b4e4-00a7-11eb-329f-9314a4b34b3d


# ╔═╡ Cell order:
# ╠═a924e8d2-00a7-11eb-1da9-7b63cefd7e7f
# ╠═7ed89550-00a8-11eb-23ce-171451ed0034
# ╠═c298a33a-00a7-11eb-26b1-4b92fd9c7a1a
# ╠═c2720644-00a7-11eb-3109-b1958120835b
# ╠═c258b194-00a7-11eb-099e-432a401b6455
# ╠═334d76cc-00a9-11eb-0326-6d811b47fec9
# ╠═c242b3da-00a7-11eb-03d1-992cd42570a3
# ╠═13827d56-00a9-11eb-11a7-db2cba0e4df9
# ╠═13830d5c-00a9-11eb-3450-0b0fd817fb5f
# ╠═dbaaf6ac-00a9-11eb-38d2-db79aff72fea
# ╠═13839394-00a9-11eb-21ed-d3665e3a7ddd
# ╠═c22d149e-00a7-11eb-13b9-3d4dd02afaf7
# ╠═27856782-00a9-11eb-03bb-09334ef6503b
# ╠═c2136576-00a7-11eb-05f5-8f1a400c0807
# ╠═c1f9cab2-00a7-11eb-1290-197d227f501d
# ╠═c1e1a7ca-00a7-11eb-31ce-ef107afd65e1
# ╠═4e1320b0-00a9-11eb-2238-6341050b81d3
# ╠═4e136a5c-00a9-11eb-21c9-21a912560f06
# ╠═4e18c64e-00a9-11eb-3ef0-fb9c16fadaeb
# ╠═4e264596-00a9-11eb-2a6c-f5d97ef7f3fc
# ╠═4e323bb2-00a9-11eb-30b0-fb2ce344922f
# ╠═4e3e77c4-00a9-11eb-11b0-c573ba931ddf
# ╠═6eb3eb74-00a9-11eb-1644-b99954e0e396
# ╠═c1cbee24-00a7-11eb-10a5-19671ebfbba0
# ╠═6e2c9b4c-00a9-11eb-2143-05b9d5f10d34
# ╠═97387a7e-00a9-11eb-02bf-c32f6cf6a44c
# ╠═971f95e2-00a9-11eb-3b77-01a355e57e36
# ╠═1b68bcf0-00aa-11eb-07eb-7bcb884131b6
# ╠═1b6aac3e-00aa-11eb-25db-437b5ab88970
# ╠═1b6fffd8-00aa-11eb-0c74-15018b32fb67
# ╠═1b809bc2-00aa-11eb-08a8-556c4be98b65
# ╠═1b94228c-00aa-11eb-1912-198c4db7489f
# ╠═1ba9491e-00aa-11eb-1de4-c7ef7734201d
# ╠═970b8410-00a9-11eb-2e64-69b92a4aa6a1
# ╠═96f3ce42-00a9-11eb-3a58-e72738661bfa
# ╠═c03ba6ac-00aa-11eb-3753-c97eec7f6037
# ╠═c03d7cb6-00aa-11eb-174f-69706ec67bc7
# ╠═c03f892a-00aa-11eb-2841-75766a3344fb
# ╠═c04ee316-00aa-11eb-1bcb-3dbe6195aced
# ╠═c061e3aa-00aa-11eb-22e0-65a09cb4f612
# ╠═c077ca42-00aa-11eb-1278-e1dda526d7d3
# ╠═c090fb54-00aa-11eb-2d9c-1529483e9445
# ╠═c0a6f8da-00aa-11eb-0e3a-35db0db694ad
# ╠═c1662c44-00a7-11eb-25e9-efc6fe2a397a
# ╠═54609382-00ac-11eb-1da3-bbfde46e8c8e
# ╠═5462c056-00ac-11eb-27f6-6b6772dc928f
# ╠═5468a568-00ac-11eb-19c4-718f77a122ea
# ╠═547aed22-00ac-11eb-1dd4-35c35ef49c12
# ╠═548d9668-00ac-11eb-3f61-0d2323624792
# ╠═54a0b494-00ac-11eb-394d-29bdd91c9c68
# ╠═c14d034a-00a7-11eb-3ccc-6324222ab747
# ╠═4258ce06-00ad-11eb-0a7d-757963205b3b
# ╠═c134c80c-00a7-11eb-1278-85c17d8b1064
# ╠═78fa09c0-00b4-11eb-395b-250cca2edf33
# ╠═b5a9d100-00b4-11eb-0002-117348c85407
# ╠═8d75f5ce-00b4-11eb-294b-8f6f23cfee9a
# ╠═c0c345a6-00a7-11eb-2156-9ff8e85ab512
# ╠═3631231e-00b5-11eb-0732-23c8a3803d55
# ╠═c0aa817e-00a7-11eb-08b1-9b07e7bad09c
# ╠═c099995e-00a7-11eb-1ebe-430425edca80
# ╠═c2af929e-00b5-11eb-3415-c3146663e6d8
# ╠═c0829c86-00a7-11eb-1fd8-4dcc7a07a50a
# ╠═e61947b6-00b5-11eb-2bdc-7973d028b67c
# ╠═e61d3e28-00b5-11eb-397b-45a3ffa64d58
# ╠═e62c4dca-00b5-11eb-024e-1bff841e4a81
# ╠═e65fc2c2-00b5-11eb-070a-29ee7397c9e3
# ╠═e68396fc-00b5-11eb-2d92-87c305bd58c8
# ╠═e6ace75a-00b5-11eb-1111-a716200eec2f
# ╠═e6d5fc08-00b5-11eb-17f2-f53cc1d9a4d8
# ╠═c06c357c-00a7-11eb-3a84-7bb0f0893e54
# ╠═c064eb6e-00a7-11eb-1ed9-539df755a5ec
# ╠═c011ea54-00a7-11eb-293e-c5a918f7445b
# ╠═bfe9b4e4-00a7-11eb-329f-9314a4b34b3d
