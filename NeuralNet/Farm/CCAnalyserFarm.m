//
//  CCAnalyserFarm.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCAnalyserFarm.h"
#import "CCAnalyser.h"
#import "CCNeuralNet.h"
#import "CCGenome.h"
#import "CCGeneticAlgorithm.h"

@interface CCAnalyserFarm ()

@property (nonatomic, assign) NSInteger currentGeneration;
@property (nonatomic, strong) NSArray *trainingData;
@property (nonatomic, strong) CCGeneticAlgorithm *geneticAlgorithm;

@end

@implementation CCAnalyserFarm

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.geneticAlgorithm = [[CCGeneticAlgorithm alloc] init];
        
        self.currentGeneration = 0;
        
        self.trainingData = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TrainingData" ofType:@"plist"]];
        
        NSMutableArray *mutableAnalysers = [NSMutableArray array];
        
        for (int i=0; i<40; ++i) {
            [mutableAnalysers addObject:[[CCAnalyser alloc] init]];
        }
        
        self.analysers = mutableAnalysers;
    }
    return self;
}

- (void)updateAnalysers
{
    NSLog(@"Generation: %ld", (long)++self.currentGeneration);
    
    NSInteger minimumFitness = 999999;
    NSInteger maximumFitness = 0;
    NSInteger totalFitness = 0;
    
    // run the training data through each analyser
    for (CCAnalyser *analyser in self.analysers) {
        [analyser reset];
        [self updateAnalyser:analyser];
        totalFitness += analyser.fitness;
        minimumFitness = MIN(minimumFitness, analyser.fitness);
        maximumFitness = MAX(maximumFitness, analyser.fitness);
    }
    
    NSLog(@"Max Fitness: %ld", (long)maximumFitness);
    NSLog(@"Min Fitness: %ld", (long)minimumFitness);
    NSLog(@"AVG Fitness: %f", (float)totalFitness/(float)self.analysers.count);
    
    [self createNewPopulation];
}

- (void)createNewPopulation
{
    NSMutableArray *genomePopulation = [NSMutableArray arrayWithCapacity:self.analysers.count];
    
    for (CCAnalyser *analyser in self.analysers) {
        [genomePopulation addObject:[CCGenome genomeWithWeights:[analyser.brain weights] fitness:analyser.fitness]];
    }
    
    NSArray *newPopulation = [self.geneticAlgorithm epoch:genomePopulation];
    
    [self.analysers enumerateObjectsUsingBlock:^(CCAnalyser *analyser, NSUInteger idx, BOOL *stop) {
        CCGenome *genome = newPopulation[idx];
        [analyser.brain setWeights:genome.weights];
    }];
}

- (void)updateAnalyser:(CCAnalyser *)analyser
{
    for (NSDictionary *pixelData in self.trainingData) {
        NSArray *result = [analyser analysePixelInput:pixelData[@"pixels"]];
        
        NSNumber *output;
        
        if (result && result.count == 1) {
            output = result[0];
        }
        
        if (output && [output intValue] == [pixelData[@"isvalid"] intValue]) {
            [analyser incrementFitness];
        }
    }
}

- (CCAnalyser *)bestAnalyser
{
    CCAnalyser *bestAnalyser;
    NSInteger maxFitness = 0;
    
    for (CCAnalyser *analyser in self.analysers) {
        if (analyser.fitness >= maxFitness) {
            maxFitness = analyser.fitness;
            bestAnalyser = analyser;
        }
    }
    return bestAnalyser;
}

@end
