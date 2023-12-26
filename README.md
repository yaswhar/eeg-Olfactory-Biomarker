# Signals & Systems Course Project

## Analysis of Phase Locking Value during Olfactory Stimulation as a Biomarker for Alzheimer's Disease in EEG Signals

This repository contains my course project for the Signals & Systems course at Sharif University of Technology.

### Project Overview

The goal of this project was to identify early biomarkers for Alzheimer's disease and related brain disorders through analysis of EEG signals during olfactory stimulation.  

Key aspects explored:

- Understanding the link between olfactory dysfunction and neurodegenerative diseases like Alzheimer's  
- Using electroencephalography (EEG) to capture brain signal patterns
- Preprocessing and analyzing EEG signals  
- Calculating phase locking value (PLV) to quantify phase synchronization between EEG channels 
- Comparing PLV responses to olfactory stimulation between Alzheimer's patients and healthy controls

### Repository Contents

The repository contains the following key files:

- `SignalsSystems_Project1402.pdf`: Original project report  
- `README.md`: This file
- `code/`: Folder containing MATLAB code files for EEG preprocessing, PLV analysis, and result visualization
- `data/`: Sample input EEG data provided for analysis  
- `results/`: Key output plots and visualizations generated from analysis

### Running the Analysis

To rerun the analysis:

1. Ensure MATLAB is installed
2. Open `code/run_analysis.m` script  
3. Set input and output paths as needed 
4. Run script to execute preprocessing and PLV computation on sample data
5. Output results will be saved to `results/` folder

### References

@misc{ref-nih,
  title = {Neurodegenerative Diseases},
  howpublished = {https://www.niehs.nih.gov/research/supported/health/neurodegenerative/index.cfm},
  note = {Last Reviewed: June 09, 2022}
}

@INPROCEEDINGS{ref-olfactory,
  author={Marin C and Vilas D and Langdon C and Alobid I and López-Chacón M and Haehner A and Hummel T and Mullol J.},
  booktitle={Curr Allergy Asthma Rep},
  title={Olfactory Dysfunction in Neurodegenerative Diseases},
  year={2018 Jun 15},
  volume={18},
  doi={0.1007/s11882-018-0796-4}
}

@misc{freq-bands,
  title = {Neural Oscillations – Interpreting EEG Frequency Bands},
  howpublished = {https://imotions.com/blog/learning/best-practice/neural-oscillations/},
}

@INPROCEEDINGS{PAC-nature,
  author={Munia, T.T.K. and Aviyente, S.}, 
  booktitle={Scientific Reports 9, 12441},
  title={Time-Frequency Based Phase-Amplitude Coupling Measure For Neuronal Oscillations},
  year={27 August 2019},
  doi={10.1038/s41598-019-48870-2}
}

@misc{mayo-MCI,
  title = {Mild Cognitive Impairment (MCI)},
  howpublished = {https://www.mayoclinic.org/diseases-conditions/mild-cognitive-impairment/symptoms-causes/syc-20354578#:~:text=Overview,mental%20function%20has%20%22slipped.%22},
  note = {Last Reviewed: Jan. 18, 2023}
}

@article{olfactory-trigeminal,
  author = {Tremblay, Cécilia and Frasnelli, Johannes},
  title = "{Olfactory and Trigeminal Systems Interact in the Periphery}",
  journal = {Chemical Senses},
  volume = {43},
  number = {8},
  pages = {611-616},
  year = {2018},
  month = {07},
  issn = {0379-864X},
  doi = {10.1093/chemse/bjy049},
}

@article{EEG-Dataset,
  title = {Brain electrophysiological recording during olfactory stimulation in mild cognitive impairment and Alzheimer disease patients: An EEG dataset},
  journal = {Data in Brief},
  volume = {48},
  pages = {109289},
  year = {2023},
  issn = {2352-3409},
  doi = {https://doi.org/10.1016/j.dib.2023.109289},
  author = {Mohammad Javad Sedghizadeh and Hamid Aghajan and Zahra Vahabi},
}

@article{olfactory-deficit-AD,
  title = {Olfactory response as a marker for Alzheimer’s disease: Evidence from perceptual and frontal lobe oscillation coherence deficit},
  journal = {PLOS One},
  volume = {15(12)},
  year = {December 15, 2020},
  doi = {https://doi.org/10.1371/journal.pone.0243535},
  author = {Sedghizadeh MJ and Hojjati H and Ezzatdoost K and Aghajan H and Vahabi Z and Tarighatnia H} 
}

@article{MAHARAJH2010542,
  title = {Fluctuation of gamma-band phase synchronization within the auditory cortex in schizophrenia},
  journal = {Clinical Neurophysiology},
  volume = {121},
  number = {4},
  pages = {542-548},
  year = {2010},
  issn = {1388-2457},
  doi = {https://doi.org/10.1016/j.clinph.2009.12.010},
  author = {Keeran Maharajh and Peter Teale and Donald C. Rojas and Martin L. Reite},
}

@article{COSTA2006159,
  title = {EEG phase synchronization during emotional response to positive and negative film stimuli},
  journal = {Neuroscience Letters},
  volume = {406},
  number = {3},
  pages = {159-164},
  year = {2006},
  issn = {0304-3940},
  doi = {https://doi.org/10.1016/j.neulet.2006.06.039},
  author = {Tommaso Costa and Elena Rognoni and Dario Galati},
}

@article{WOMELSDORF2007154,
  title = {The role of neuronal synchronization in selective attention},
  journal = {Current Opinion in Neurobiology},
  volume = {17},
  number = {2},
  pages = {154-160},
  year = {2007},
  note = {Cognitive neuroscience},
  issn = {0959-4388},
  doi = {https://doi.org/10.1016/j.conb.2007.02.002},
  author = {Thilo Womelsdorf and Pascal Fries},
}

@article{LOPEZ201970,
  title = {Dynamic low frequency EEG phase synchronization patterns during proactive control of task switching},
  journal = {NeuroImage},
  volume = {186},
  pages = {70-82},
  year = {2019},
  issn = {1053-8119},
  doi = {https://doi.org/10.1016/j.neuroimage.2018.10.068},
  author = {María Eugenia López and Sandra Pusil and Ernesto Pereda and Fernando Maestú and Francisco Barceló},
}

@article{https://doi.org/10.1111/ejn.13767,
  author = {Palva, J. Matias and Palva, Satu},
  title = {Functional integration across oscillation frequencies by cross-frequency phase synchronization},
  journal = {European Journal of Neuroscience},
  volume = {48},
  number = {7},
  pages = {2399-2406},
  keywords = {cognition, cross-frequency, magnetoencephalography, oscillations, synchronization},
  doi = {https://doi.org/10.1111/ejn.13767},
  year = {2018}
}

@article{BIEL2021117971,
  title = {EEG cross-frequency phase synchronization as an index of memory matching in visual search},
  journal = {NeuroImage}, 
  volume = {235},
  pages = {117971},
  year = {2021},
  issn = {1053-8119},
  doi = {https://doi.org/10.1016/j.neuroimage.2021.117971},
  author = {Anna Lena Biel and Tamas Minarik and Paul Sauseng},
}

Let me know if any clarification or additional information is needed!
