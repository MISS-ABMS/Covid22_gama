/**
* Name: Covid22
* Based on the internal empty template. 
* Author:
* Tags: 
*/


model Covid22

global {

	csv_file ssc_spatialgrid0_csv_file <- csv_file("../includes/ssc_spatial-grid.csv");

	float step <- #hour;

	map<string,rgb> lucmap <- [""::#white,"H"::#grey,"I"::#yellow,"W"::#mediumorchid,"S"::#orange];
	map<string,rgb> statemap <- ["susceptible"::#blue,"immune"::#green,"infected"::#red];
	
	int nb_agent <- 100;

	init {
		matrix m <- matrix(ssc_spatialgrid0_csv_file);
		ask landscape { 
			luc <- m[grid_x, grid_y];
			color <- lucmap[luc];
		}
		create people number:nb_agent {
			
		}
	}

}

species people {
		
	string epidemiological_state init:"susceptible" among:["susceptible","immune","infected"];
	bool symptomatic;
	
	list<people> family;
		
	aspect default { draw circle(1); }
}

grid landscape width:30 height:30 {
	
	string luc; // among:["nil","H","I","W","S"]; // land-use / cover
	
}

experiment xp type:gui {
	output {
		display main {
			grid landscape lines:#black;
			species people;
		}
	}
}
