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
	date starting_date <- date(2022,date(#now).month,date(#now).day,7);

	map<string,rgb> lucmap <- [""::#white,"H"::#grey,"I"::#yellow,"W"::#mediumorchid,"S"::#orange];
	map<string,rgb> statemap <- ["susceptible"::#green,"immune"::#blue,"infected"::#red];
	
	int nb_agent <- 100;
	
	float proportion_of_working_agent <- 0.5;
	
	int nb_infect_start <- 1;
	
	float proba_transmission <- 0.1;
	float proba_asymptomatic <- 0.2;

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
			remaining_people <- remaining_people - a_family;
			ask a_family {
				family <- a_family-self; 
				familyID <- id;
			}
			id <- id + 1;
		}
		
		list<list<landscape>> workingplaces <- list<list<landscape>>(
			simple_clustering_by_distance(landscape where (each.luc = "W"), 1)
		);
		loop cluster over: workingplaces {
        	create building with:[extend::cluster,type::"W"];
        }
		
		list<list<landscape>> schoolplaces <- list<list<landscape>>(
			simple_clustering_by_distance(landscape where (each.luc = "S"), 1)
		);
		loop cluster over: schoolplaces {
        	create building with:[extend::cluster,type::"S"];
        }
		
		list<list<landscape>> isolationplace <- list<list<landscape>>(
			simple_clustering_by_distance(landscape where (each.luc = "I"), 1)
		);
		loop cluster over: isolationplace {
        	create building with:[extend::cluster,type::"I"];
        }
		
		// Choose the homeplace / workplace
		map<int,list<people>> families <- people group_by each.familyID;
		list<landscape> available_homeplaces <- landscape where (each.luc="H");
		
		loop f over:families.values {
			landscape the_home <- one_of(available_homeplaces);
			loop p over:f { 
				p.home <- the_home; 
				p.workplace <- (flip(proportion_of_working_agent) ? 
					any(building where (each.type="W")) : any(building where (each.type="S"))
				);
			} 
			available_homeplaces >- the_home;
		}
		
		// Locate people into homeplaces
		ask people { location <- any_location_in(home); current_place <- home; }
		
		ask nb_infect_start among people { epidemiological_state <- "infected"; }
		
	}

}

species people {
		
	string epidemiological_state init:"susceptible" among:["susceptible","immune","infected"];
	date date_of_infection; // TODO
	bool symptomatic;
	
	list<people> family;
	int familyID;
	
	landscape home;
	building workplace;
	
	agent current_place;
	
	// To transmit the virus 
	reflex transmission when: epidemiological_state="infected" {
		list<people> people_in_the_same_building <- people where 
			(each.epidemiological_state = "susceptible" and each.current_place = current_place);
		ask people_in_the_same_building {
			if flip(proba_transmission) {
				epidemiological_state <- "infected";
				symptomatic <- flip(proba_asymptomatic) ? false : true;
			}
		}
	}
	
	// Go to work or school
	reflex going_to_worlplace when:current_date.hour = 8 {
		current_place <- workplace;
		location <- any_location_in(workplace);
	}
		
	// Get back home
	reflex get_back_home when:current_date.hour = 17 {
		current_place <- home;
		location <- any_location_in(home);
	}
		
	aspect default { draw circle(1) color: statemap[epidemiological_state] border: #black; }
}

species building {
	
	string type;
	list<landscape> extend;
	
	init { shape <- union(extend); }
	
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
