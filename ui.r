library(shiny)

shinyUI(fluidPage(
	titlePanel("Comparison of KNN, CART and Random Forests classification methods"),
	sidebarPanel(
		textInput("seed", "Enter random number generator (seed):", "12345"),
		sliderInput("p", "Relative size of training set in percent:",
			min=0, max=100, value=60, step=5),
		radioButtons('method', label="Choose classification method:", choices=list(
			"k-nearest neighbours (KNN)"="knn",
			"CART"="rpart",
			"Random Forests"="rf"),
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
			),
			tabPanel("Help",
				h3('How to use this application'),
				p("In this application we compare performance of three classification algorithms:
				k-nearest neighbours (KNN), CART and Random Forests (RF). To compare we use the iris 
				data set available in R. The iris data set will be divided into a training set
				and a testing set. We then train algorithms on the train set and perform prediction
				on the testing set. The predictors are Sepal.Width, Sepal.Length, Petal.Width and
				Petal.Length variables. The outcome to be predicted is Species variable."),

				p("The application receives inputs and produces prediction represented in plots,
				tables and texts. The inputs include: seed value, size of the training set in
				percentage (with reference to the whole iris data set) and algorithm to perform classification.
				Classification/prediction output will be represented in plots, confusion matrix and tables."),

				p("To change inputs, use the \"Enter random number generator\" input box, the
				\"Relative size of training set in percent\" input slider and the \"Choose classification
				method\" checkbox. The first two inputs change content of training and testing data sets
				while the last input changes the algorithm to perform classfication/prediction."),

				p("The output include plots, the confusion matrix and details on data sets. By default the application
				produces two plots in the \"Plots\" tab. The first one depicts classification results and
				the second one describes the test data set divided by Species variable. Data items in the same
				class have the same color. They are also grouped by 2D density plots in the graph for easy viewing.
				Initially the two plots use Petal.Length and Petal.Width as x-axis and y-axis respectively.
				You can change the x-axis and y-axis using the
				two checkboxes on the left \"Choose y-axis of the plot\" and \"Choose y-axis of the plot\".
				If the x-axis and y-axis are the same, the pairs plot will be produced. The next output,
				confusion matrix will be presented in detail in the \"Confusion matrix\" tab. The training
				and testing data sets is browsed in \"The iris data sets\" tab. Classfication results are in
				\"Classification details\" tab. While browsing this table you can enter \"False\" in the
				search box to find incorrectly classfied data items."),
				p("The others tabs provides this help and information about the developer of this application."),
				p("Note: If you enter large size of the training data set, for example larger than 90%,
				the 2D density plots may not be available.")
			),
			tabPanel("About",
				h4('Developed by Chau Nguyen, 2015. Email: nhchau@gmail.com')
			)
		)
	)
))

