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
	
	float proportion_of_working_agent <- 0.5;

	init {
		
		matrix m <- matrix(ssc_spatialgrid0_csv_file);
		ask landscape { 
			luc <- m[grid_x, grid_y];
			color <- lucmap[luc];
		}
		create people number:nb_agent;
		
		// Build families
		list<people> remaining_people <- list(people);
		int id;
		loop while:not empty(remaining_people) {
			list<people> a_family <- 4 among remaining_people;
			remaining_people >>- a_family;
			ask a_family {family <- a_family-self; familyID <- id;}
			id <- id + 1;
		}
		
		// Choose the homeplace / workplace
		map<int,list<people>> families <- people group_by each.familyID;
		list<landscape> available_homeplaces <- landscape where (each.luc="H");
		list<landscape> available_workingplaces <- landscape where (each.luc="W");
		list<landscape> available_schools <- landscape where (each.luc="S");
		write sample(available_homeplaces);
		loop f over:families.values {
			landscape the_home <- one_of(available_homeplaces);
			write sample(the_home);
			loop p over:f { 
				p.home <- the_home; 
				p.workplace <- (flip(proportion_of_working_agent) ? any(available_workingplaces) : any(available_schools));
			} 
			available_homeplaces >- the_home;
		}
		
		// Locate people into homeplaces
		ask people { location <- any_location_in(home); }
		
	}

}

species people {
		
	string epidemiological_state init:"susceptible" among:["susceptible","immune","infected"];
	bool symptomatic;
	
	list<people> family;
	int familyID;
	
	landscape home;
	landscape workplace;
		
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
