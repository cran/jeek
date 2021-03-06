library(jeek)


### plotting window reset routine
graphics.off()
par(ask=F)
par(mfrow=c(1,1))


readline(prompt="Press [enter] to continue to cancer demo with 2 tasks (not v. pcr) and 26 features (26 cancer types) ")

### load cancer data (cancer)
data(cancer)

### create a list of cancer data (cancerlist)
cancerlist = list(as.matrix(cancer[[1]][which(cancer[[2]] == "not"),]),
                  as.matrix(cancer[[1]][which(cancer[[2]] == "pcr"),]))

### run jeek
result = jeek(X = cancerlist, 0.25, covType = "kendall", parallel = TRUE)

### obtain names for node labelling
label = colnames(cancer[[1]])

### obtain graph for creating layout
graph = returngraph(result)

### create a fixed layout on cancergraph for plotting
layout = layout_nicely(graph,dim=2)



### multiple plotting
readline(prompt="Press [enter] to display four plots showing all graphs, shared graph, task specific 1 and task specific 2")

par(mfrow=c(2,2))

{
  plot.jeek(result, graphlabel = label, type="task", graphlayout = layout)

  plot.jeek(result, graphlabel = label, type="share", graphlayout = layout)

  plot.jeek(result, graphlabel = label, type="taskspecific", subID=1, graphlayout = layout)

  plot.jeek(result, graphlabel = label, type="taskspecific", subID=2, graphlayout = layout)
}

readline(prompt="Press [enter] to display four plots zooming into node MELK, E2F3 and BB_S4 on previous four plots")

nodeid = which(label %in% c("MELK","E2F3", "BB_S4")) ### look for id
{
  plot.jeek(result, graphlabel = label, type="neighbour", index = nodeid, graphlayout = layout)

  plot.jeek(result, graphlabel = label, type="neighbour", subID = 0, index = nodeid,graphlayout = layout)

  plot.jeek(result, graphlabel = label, type="neighbour", neighbouroption = "taskspecific",
              subID=1, index = nodeid,
              graphlayout = layout)

  plot.jeek(result, graphlabel = label, type="neighbour", neighbouroption = "taskspecific",
              subID=2, index = nodeid,
              graphlayout = layout)
}

