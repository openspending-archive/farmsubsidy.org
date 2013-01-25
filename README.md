FarmSubsidy.org 2.0 prototype
=============================

This repository contains components used for a new version of the
FarmSubsidy web site based upon the OpenSpending platform. The idea is
to load farm subsidy data into the OpenSpending database and then use 
the aggregation API to generate all required rankings. Because farm 
subsidy data is quite large, generating rankings cannot be done online.
The application therefore includes a node.js frontend that caches
requests from the aggregator and renders the web site from cache. This
would become redundant should OpenSpending come up with an efficient 
mechanism for pre-aggregation or internal results storage. 


