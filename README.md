# Covid22_gama

The model is based on an imaginary new version of the covid19 disease and has been coded during the MISS-ABMS20 online teaching course

## Starting point description to model an imaginary version of Covid22

Similarly to CoViD-19, __CoViD-22 mainly spreads through a close contact between an infectious person and a susceptible person__. As far as we know, in such a situation, __the probability of contagion is around 10%__.  As the virus does not immediately manifest itself in its host, infected individuals go through an __incubation stage (5 days)__ before becoming infectious. Not all infectious persons show symptoms: __20% of them remain asymptomatic__. __The infectiousness__ does __not__ appear to be __related to the manifestation of symptoms__. __Diagnostic tests exist__ and are able to identify any infectious person (both symptomatic and asymptomatic). __45 days after becoming infectious, a person recovers and gets immune__. 

To control the epidemic, two strategies are considered: 

i) people are requested to stay at home (containment); 
ii) individuals tested positive are isolated (testing-and-isolating). 

Health authorities are requesting the scientific community working with agent-based simulation to provide insights about the relative efficiency of both strategies. For the __containment strategy__, two dimensions are especially scrutinized: __the effect of compliance__ with containment and __the duration__ of such measure.  For the testing-and-isolating strategy, a special attention will be given to __the number of individuals to be tested__ on a daily basis and whether or not __the presence of symptoms is considered in the selection of people to be tested__.

To serve as a reference basis, a stylized situation of a district is proposed. *100 inhabitants* are introduced in an *environment made of 30x30 places*. Each inhabitant lives with the *3 other members of their family in a house*. Each individual *spends the day* either in a *working place or at school* and *the night at home*.

# Model description
 
The model description follows the ODD protocol for describing individual- and agent-based models (Grimm et al. 2006; 2010, 2020) and consists of seven elements. The first three elements provide an overview, the fourth element explains general concepts underlying the model’s design, and the remaining three elements provide details.
 
## O::Purpose

Methodology for preventing spread (decision support) or provide evidence on how the virus would spread (understanding) ? 
In the text : “Health authorities are requesting the scientific community working with agent-based simulation to provide insights about the relative efficiency of both strategies”
-> we will need indicators for comparing the efficiency of the strategies 
 
## O::Entities State variables and scales

probabilities of contagion , being symptomatic  / asymptomatic ? in the test-and-isolate, how is it decided who will be tested ? 

### Person 

### Grid

### Global 
 
## O::Process overview and scheduling

## DC::Initialization
 
## DC::Input
 
<”Input” refers to environmental variables, that “drive” the dynamics of your model system (ecology: rainfall; econmics: work market price; physiology: pH of blood) and that are not produced (calculated) by the model itself, but imported from an external model or file. This does not include static landscape (GIS), but might include dynamic landscapes. In the course, you probably will have no Input.>
 
## DC::Submodels
 
< Here you would, once your model and its analysis is finished, describe the submodels of your model, i.e. the procedures.>

## De::Emergence
A certain system property or behaviour is emergent if it is not directly specified by individual traits. Which properties of the model system really do emerge from the interaction of the adaptive behaviour of the individuals, and which are merely imposed? For example, assuming a constant mortality rate means that mortality has been imposed, whereas if the sources of mortality are modelled mechanistically (e.g., including feeding, habitat choice, predation) then the mortality rate and population dynamics emerge from adaptive traits.

## De::Adaptation
Adaptation here refers to some kind of active choice by the individuals among alternative behaviours, with the decision depending on environmental or internal conditions. What adaptive traits do the model individuals have to improve their potential fitness, in response to changes in themselves or their environment?

## De::Fitness
In biology, fitness is the success of an individual in passing on its genes to succeeding generations; in an IBM, fitness is a consequence of behaviour. If the modelled agent is not biological, or if the modelled period is shorter than the life span of the organism, then fitness is replaced by a goal-function chosen by the modeller. Is fitness-seeking modelled explicitly (i.e. do individuals base their decision on explicit estimations of fitness) or is fitness-seeking more implicit, for example by implicitly assuming that certain decisions contribute to fitness? If fitness-seeking is modelled explicitly, how do individuals calculate fitness, i.e. what is their internal model of how expected fitness depends on which alternative behaviour is chosen? How is the individual’s current state considered in modelling fitness consequences of decisions? Does the individual’s internal fitness model change with life stage, season, or other conditions?

## De::Prediction
Prediction refers to the way an IBM represents how individuals foresee the future outcomes of their decisions. Tacit prediction includes simple, implicit assumptions about decision outcomes. Overt prediction explicitly forecasts the consequences of each alternative decision (Holland 1995). In estimating the fitness consequences of their decisions, how do individuals predict the future conditions (internal as well as environmental) they will experience? Do the individuals’ predictions make use of memory or learning or environmental cues?  If fitness-seeking is not modelled explicitly, what tacit (i.e., not explicitly stated and modelled) predictions are included in the IBM? What assumptions are implicitly embedded in the tacit predictions?

## De::Interaction
Interactions are mechanisms by which model individuals communicate with each other or otherwise affect each other. How do individuals interact? Do they interact directly, i.e., via preying upon one another, or indirectly, for example, through consumption of a shared resource? Are interactions local (in the neighbourhood of an individual) or global (with all individuals in the system)? How are interactions in the model related to real interaction mechanisms?

## De::Sensing
Sensing is the way an IBM represents how individuals obtain information about their (internal and external) environment and neighbouring individuals. What state variables are individuals assumed to “know”, or sense? Does the IBM represent the actual sensing or information gathering process? How accurate, or certain is the individual’s information?

## De::Stochasticity
Stochasticity in an IBM means that pseudo-random numbers are used to represent a process or trait. Is stochasticity used to simulate variability in input variables (see element ‚Input’ above)? What low-level processes are represented empirically as stochastic processes? What behavioural traits use stochastic processes to reproduce behaviour observed in real organisms? Is this approach clearly recognized and used as an empirical model?

## De::Collectives
Collectives are aggregations of individuals, e.g. bird flocks and social groups, that have their own characteristics and behaviour. Collectives are an intermediate level of organization between individuals and populations. Are collectives represented in the IBM? Do collectives occur only as phenomena emerging from individual behaviour, or are individuals given traits that impose the formation of collectives? Are collectives represented as explicit entities with their own state variables and traits?

## De::Observation
Observation is the process of collecting data and information from an IBM; typical observations include graphical display of patterns over space and time and file output of summary statistics. What kinds of model results are observed to test the IBM and meet its objectives? From what perspectives are observations of results taken: omniscient, model individual, or virtual ecologist (a simulated ecologist, which is not omniscient but applies a certain protocol to collect data in the model system)?
