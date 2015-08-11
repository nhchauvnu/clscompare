library(shiny)
library(caret)
library(ggplot2)
library(readr)

shinyServer(
function(input, output) {
	# Relvel for easy color separation while viewing
	iris$Species = relevel(iris$Species, "versicolor")
	iris$Species = relevel(iris$Species, "virginica")
	irisname = names(iris)
	# First we create train and test data sets
	classification = reactive({
		p = input$p/100
		set.seed(as.integer(input$seed))
		method = input$method

		index = createDataPartition(iris$Species, p=p, list=F)
		traindata = iris[index,]
		testdata = iris[-index,]

		fit = train(Species ~ ., method=method, data=traindata)	# Train
		test = predict(fit, testdata[,-5])	# Predict on the test data set
		m = confusionMatrix(testdata[,5], test)

		if (method == 'knn') method = 'KNN'
		if (method == 'rpart') method = 'C4.5'
		rm(traindata)
		rm(testdata)

		list(-index, test, method, m)
	})
	orgdata <- reactive({
		p = input$p/100
		set.seed(as.integer(input$seed))
		index = createDataPartition(iris$Species, p=p, list=F)
		list(-index)
	})
	output$iristable = renderDataTable({
		dt = orgdata()
		dtset = rep("training", nrow(iris))
		dtset[dt[[1]]] = "testing"
		iris1 = cbind(iris, Set=dtset)
	}, options=list(pageLength=10))
	output$testtable = renderDataTable({
		dt = classification()
		index = dt[[1]]
		test = dt[[2]]
		testtable = cbind(iris[index,], ClassifiedAs=test,
			Result=(test==iris$Species[index]))
	}, options=list(pageLength=10))
	output$confusionmatrix = renderPrint({
		dt = classification()
		dt[[4]]
	})
	output$graph1 <- renderPlot({
		d1 = as.integer(input$dim1)
		d2 = as.integer(input$dim2)
		dt = classification()
		index = dt[[1]]
		testdata = iris[index,]
		test = dt[[2]]
		method = dt[[3]]
		m = dt[[4]]
		# Plot classes
		pldata = testdata[, c(d1, d2, 5)]
		pldata = cbind(pldata, test)
		names(pldata) = c('x', 'y', 'Species', 'Classification')
		acc  = format(m$overall['Accuracy'], digit=3)
		accl = format(m$overall['AccuracyLower'], digit=3)
		accu = format(m$overall['AccuracyUpper'], digit=3)
		pval = format(m$overall['AccuracyPValue'], digit=3)
		if (d1==d2)
			plot(testdata[,-5], col=test,
			main=paste0('The iris test data set classified by ', method,' method'))
		else {
			ttl = paste0('The iris test data set classified by ', method, " method\n")
			ttl = paste0(ttl, 'Accuracy: ', acc)
			ttl = paste0(ttl, ', 95% CI: (', accl,',', accu,')')
			ttl = paste0(ttl, ', p-value=', pval)
			# Plot classes and their borders
			ggplot(data=pldata, aes(x=x, y=y, color=Classification))+
				ggtitle(ttl) + xlab(names(iris)[d1]) + ylab(names(iris)[d2])+
				geom_point(size=3)+stat_density2d()
		}
	})
	output$graph2 <- renderPlot({
		dt = orgdata()
		index = dt[[1]]
		d1 = as.integer(input$dim1)
		d2 = as.integer(input$dim2)

		pldata = iris[index, c(d1, d2, 5)]
		names(pldata) = c('x', 'y', 'Species')
		if (d1==d2)
			plot(iris[index,-5], col=iris$Species[index],
			main="The iris test data set divided by species")
		else {
			ttl = paste0("The iris test data set divided by species\n")
			# Plot classes and their borders
			ggplot(data=pldata, aes(x=x, y=y, color=Species))+
				ggtitle(ttl) + xlab(names(iris)[d1]) + ylab(names(iris)[d2])+
				geom_point(size=3)+stat_density2d()
		}
	})
}
)

