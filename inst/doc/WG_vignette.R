## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------

#Clean workspace and memory ----
rm(list=ls())
gc()

#Set working directory ----
gps0=getwd()
gps0=paste(gps0,"/%s",sep="")
rootDir=gps0
setwd(gsub("%s","",rootDir))

#Load libraries ----
suppressWarnings(suppressMessages(
  library("Esearch3D", quietly = T)
  )
)

#Set variables ----
#Set seed to get always the same results out of this vignette
set.seed(8)
#Set number of cores to parallelize the tasks
n_cores=5

## ----loading of wg dataset----------------------------------------------------

#Load and set up the example data ----
data("wg_data_l")
#gene - fragment interaction network generated from DNase_Prop1_mESC_TSS interactions data
gf_net=wg_data_l$gf_net
#gene-fragment-fragment interaction network generated from mESC_DNase_Net interactions data
ff_net=wg_data_l$ff_net
#sample profile with starting values for genes and fragments generated from mESC_bin_matrix_Prop1
input_m=wg_data_l$input_m
#length of chromosomes
chr_len=wg_data_l$chr_len
#gene annotation
ann_net_b=wg_data_l$ann_net_b
#genes of interests
gene_in=wg_data_l$gene_in


## ----two step propagation with random walk with restart-----------------------

#Two step propagation -----
#Propagated for the network gene-fragment
gf_prop=rwr_OVprop(g=gf_net,input_m = input_m, no_cores=n_cores, r=0.1)
#Propagated for the network fragment-fragment
ff_prop=rwr_OVprop(g=ff_net,input_m = gf_prop, no_cores=n_cores, r=0.8)


## ----single gene propagation, eval = FALSE------------------------------------
#  
#  #Single gene propagation -----
#  output_path="sgPropagation_results.rda"
#  contrXgene_l=rwr_SGprop(gf_net, ff_net, gene_in = gene_in$V2[3:4], frag_pattern="frag", out_rda=output_path, degree = 4, r1 = 0.1, r2 = 0.8, no_cores = n_cores)

