//
//  CCGeneticAlgorithm.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCGeneticAlgorithm.h"
#import "CCGenome.h"

@interface CCGeneticAlgorithm ()

@property (nonatomic, assign) NSInteger totalFitness;
@property (nonatomic, strong) NSArray *population;

@end

@implementation CCGeneticAlgorithm

- (NSArray *)epoch:(NSArray *)oldPopulation
{
    self.population = oldPopulation;
    
    self.population = [self.population sortedArrayUsingSelector:@selector(compare:)];
    
    [self reset];
    [self calculateFitness];
    
    NSMutableArray *newPopulation = [NSMutableArray arrayWithCapacity:self.population.count];
    
    [self addElitesToNewPopulation:newPopulation numberOfElites:4 numberOfCopies:1];
    
    while (newPopulation.count < self.population.count) {
        CCGenome *mum = [self genomeRoulette];
        CCGenome *dad = [self genomeRoulette];
        
        NSMutableArray *baby1 = [NSMutableArray array];
        NSMutableArray *baby2 = [NSMutableArray array];
        
        [self crossoverMum:mum.weights dad:dad.weights baby1:baby1 baby2:baby2];
        
        [self mutateChromosome:baby1];
        [self mutateChromosome:baby2];
        
        [newPopulation addObject:[CCGenome genomeWithWeights:baby1 fitness:0]];
        [newPopulation addObject:[CCGenome genomeWithWeights:baby2 fitness:0]];
    }
    
    return newPopulation;
}

- (void)reset
{
    self.totalFitness = 0;
}

- (void)calculateFitness
{
    for (CCGenome *genome in self.population) {
        self.totalFitness += genome.fitness;
    }
}

#pragma mark - genetic stuff...

- (void)addElitesToNewPopulation:(NSMutableArray *)newPopulation
                  numberOfElites:(NSInteger)numberOfElites
                  numberOfCopies:(NSInteger)numberOfCopies
{
    for (int i=0 ; i<numberOfElites ; ++i) {
        for (int j=0; j<numberOfCopies; ++j) {
            [newPopulation addObject:self.population[self.population.count - 1 - i]];
        }
    }
}

- (CCGenome *)genomeRoulette
{
    NSInteger slice = arc4random_uniform((int)self.totalFitness);
    
    NSInteger fitnessSoFar = 0;
    
    for (int i=0 ; i<self.population.count ; ++i) {
        CCGenome *genome = self.population[i];
        
        fitnessSoFar += genome.fitness;
        
        if (fitnessSoFar >= slice) {
            return genome;
        }
    }
    
    return nil;
}

- (void)crossoverMum:(NSArray *)mumChromosome dad:(NSArray *)dadChromosome baby1:(NSMutableArray *)baby1 baby2:(NSMutableArray *)baby2
{
    CGFloat ranomdFloat = arc4random() / 0x100000000;
    
    if (ranomdFloat > 0.7 || mumChromosome == dadChromosome) {
        baby1 = [mumChromosome mutableCopy];
        baby2 = [dadChromosome mutableCopy];
        return;
    }
    
    int crossoverPoint = arc4random_uniform((int)mumChromosome.count);
    
    for (int i=0; i<crossoverPoint; ++i) {
        [baby1 addObject:mumChromosome[i]];
        [baby2 addObject:dadChromosome[i]];
    }
    for (int i=crossoverPoint; i<mumChromosome.count; ++i) {
        [baby2 addObject:mumChromosome[i]];
        [baby1 addObject:dadChromosome[i]];
    }
}

- (void)mutateChromosome:(NSMutableArray *)chromosome
{
    CGFloat minRange = -1;
    CGFloat maxRange = 1;
    
    for (int i=0; i<chromosome.count; ++i) {
        CGFloat randomfloat = arc4random() / 0x100000000;
        
        if (randomfloat < 0.1) {
            CGFloat ranomdMultiple = ((CGFloat)arc4random() / 0x100000000 * (maxRange - minRange)) + minRange;
            
            chromosome[i] = @([chromosome[i] floatValue] + ranomdMultiple * 0.3);
        }
    }
}

@end
