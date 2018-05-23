#!/bin/bash

# itera la richiesta 100 volte 

for i in {1..100}; do 
	curl my-swarm:8080
	echo "" ; 
done 
