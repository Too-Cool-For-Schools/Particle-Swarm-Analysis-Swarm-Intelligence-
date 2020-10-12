%%Problem Definition
CostFunction=@(x)Sphere(x); % cost function
nVar=5;   %number of unknown decision variables 
VarSize=[1 nVar]; %Matrix Size of Decision Variable
VarMin=-10; %Lower bound of Decision Variable
VarMax=10; %Upperbound of Decision Variables
%% Parameters of the PSO
%%
MaxIt=100; %maximun number of iteration
npop=50; %swarm size or population size
w=1; %inertia coefficient
c1=2; %personal accerlerration coefficient
c2=2; % Social Accerleration Coefficient
%% Initialization

empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];

%Create population array
particle=repmat(empty_particle,npop,1);

%initialization of Global best 
GlobalBest.Cost=inf; %if minimization, if maximization the value should be minus infinity 

%Initialization of population member
for i=1:npop
   %generation of random solution
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize)% random position is defined. Used CSV data for vehicle initial position 
    %Initial Velocity
    particle(i).Velocity=zeros(VarSize);
    %Evaluation
    particle(i).Cost=CostFunction(particle(i).Position);
    %Update the personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    
    %Update the global best
    if particle(i).Best.Cost<GlobalBest.Cost
        GlobalBest=particle(i).Best;
    end
    
end

%Array to hold the best cost
BestCosts=zeros(MaxIt,1);
%% Iteration Main loop of PSO
%%
for it=1:MaxIt
    for i=1:npop
       %update velocity
        particle(i).Velocity=w*particle(i).Velocity+c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position)
        +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        
        %update position
        particle(i).Position=particle(i).Position+particle(i).Velocity;
        %Evaluation
        particle(i).Cost=CostFunction(particle(i).Position);
       %update personal best
        if particle(i).Cost<particle(i).Position;
            particle(i).Best.Position=particle(i).position;
            particle(i).Best.Cost=particle(i).Cost
         end   
     %Update the global best
    if particle(i).Best.Cost<GlobalBest.Cost
        GlobalBest=particle(i).Best;
    end
        
    end
end

%array to hold best cost value on each iteration
BestCosts=zeros(MaxIt,1);
%% Results

for it=1:MaxIt
    for i=1:npop
        %store the best cost value
        BestCosts(it)=GlobalBest.Cost;
        %Display Iteration Information
        disp(['Iteration' num2str(it) ':Best Cost= ' num2str(BestCosts(it))]);
    end
    end