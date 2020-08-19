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

layout = (args...) -> spring_layout(args...; C = 20)

# ------------------------
md"# EGO NETWORK TEST"

# Ego Network (first 10000 connections)
edge_network = loadgraph(
    "/home/subhaditya/Desktop/Datasets/graph/twitter_ego_part.net",
    EdgeListFormat(),
)

# Label the Network
edgelabel = [1:LightGraphs.ne(edge_network)]

nodelabel = [1:nv(edge_network)]

nodesize =
    [LightGraphs.outdegree(edge_network, v) for v in LightGraphs.vertices(edge_network)]

nodefillc = distinguishable_colors(nv(edge_network), colorant"blue")

# Try to plot
gp = gplot(
    edge_network,
    layout = layout,
    nodesize = nodesize,
	nodefillc = nodefillc,
	nodelabeldist=1.8,
	nodelabelangleoffset=π/4
)

draw(SVG("celebri.svg", 60cm, 60cm), gp)

# Features

md"- ne = 10000, nv = 10001"
ne(edge_network)

nv(edge_network)

has_self_loops(edge_network)

## Adjacency
adjm = adjacency_matrix(edge_network)

verts = vertices(edge_network)

adjm[1,:]

## Clustering
using Clustering

kmeans(adjm, 5)


# Ego Network (random 10000 connections)
edge_network = loadgraph(
    "/home/subhaditya/Desktop/Datasets/graph/twitter_ego_shuffled.net",
    EdgeListFormat(),
)

# Label the Network
edgelabel = [1:LightGraphs.ne(edge_network)]

nodelabel = [1:nv(edge_network)]

nodesize =
    [LightGraphs.outdegree(edge_network, v) for v in LightGraphs.vertices(edge_network)]

nodefillc = distinguishable_colors(nv(edge_network), colorant"blue")

# Try to plot
gp = gplot(
    edge_network,
    layout = layout,
    nodesize = nodesize,
	nodefillc = nodefillc,
	nodelabeldist=1.8,
	nodelabelangleoffset=π/4
)

draw(SVG("celebri.svg", 60cm, 60cm), gp)

# Features

md"- ne = 10000, nv = 10001"
ne(edge_network)

nv(edge_network)

has_self_loops(edge_network)

## Adjacency
adjm = adjacency_matrix(edge_network)

verts = vertices(edge_network)

adjm[1,:]

## Clustering
using Clustering

kmeans(adjm, 5)


# ------------------------

md"# Celebrities"

## Get data
data_cels = readdlm("/home/subhaditya/Desktop/Datasets/graph/celebrities_profiles.txt", '\t') 

data_cels[1:4, :]	

cols = ["no","x1","x2","x3","x4","xn", "country", "x5", "x6", "x7", "Designation","x8","x9","profile", "x10", "x11","x12","x13", "x14","name","x15","time","timezone","x16","x17", "x18"]

data_table = DataFrame(data_cels)

names!(data_table, Symbol.(cols))

