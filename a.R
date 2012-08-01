library(igraph)
g=graph.ring(10)
a1=cocitation(g)
a2=bibcoupling(g)


g <- graph.disjoint.union(graph.full(4), graph.empty(2,directed=FALSE))
g <- add.edges(g,c(3,4,4,5,4,2))
g <- graph.disjoint.union(g,g,g)
g <- add.edges(g,c(0,6,1,7,0,12,4,0,4,1))
## Find cohesive blocks:
gBlocks <- cohesive.blocks(g)

g <- read.graph(file="http://intersci.ss.uci.edu/wiki/Vlado/SanJuanSur.net", format="pajek")
gBlocks <- cohesive.blocks(g, cutsetAlgorithm="kanevsky")



V(gg)$bte = betweenness(gg, directed = F)
png("net_betweenness.png", width = 500, height = 500)
par(mar = c(0, 2, 0, 0))
plot(V(gg)$bte)
dev.off()


d1=diameter(gg)
gd=get.diameter(gg)
gd
[1]  13  34  32 127  17 139 111 219 260
far=farthest.nodes(gg)
short=get.shortest.paths(gg,1,2)