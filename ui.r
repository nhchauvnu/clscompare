library(shiny)

shinyUI(fluidPage(
	headerPanel("Comparison of KNN, C4.5 and C5.0 classification methods"),
	sidebarPanel(
		textInput("seed", "Enter random number generator (seed):", "12345"),
		sliderInput("p", "Relative size of training set in percent\
			(if larger than 90% then some density plots may not be available):",
			min=0, max=100, value=60, step=5),
		radioButtons('method', label="Choose classification method:", choices=list(
			"k-nearest neighbours (KNN)"="knn",
			"C4.5"="rpart",
			"C5.0"="C5.0"),
			selected="knn"),
		radioButtons('dim1', label="Choose x-axis of the plot:", choices=list(
			"Sepal length"="1",
			"Sepal width"="2",
			"Petal length"="3",
			"Petal width"="4"), selected="3"),
		radioButtons('dim2', label="Choose y-axis of the plot:", choices=list(
			"Sepal length"="1",
			"Sepal width"="2",
			"Petal length"="3",
			"Petal width"="4"), selected="4")

	),
	mainPanel(
		tabsetPanel(
			tabPanel("Plots",
				plotOutput("graph1"),
				plotOutput("graph2")
			),
			tabPanel("Confusion matrix",
				verbatimTextOutput("confusionmatrix")
			),
			tabPanel("The iris dataset",
				h3('The iris data set divided by training and test sets'),
				dataTableOutput('iristable')
			),
			tabPanel("Classification details",
				h3('Detail comparison of classification on the test data set'),
				dataTableOutput('testtable')
			)
		)
	)
))

