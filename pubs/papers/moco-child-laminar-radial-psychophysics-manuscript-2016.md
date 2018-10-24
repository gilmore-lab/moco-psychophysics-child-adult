# moco-child-laminar-radial-psychophysics-manuscript-2016

## Methods and Materials  
### Participants  

All participants had normal vision or corrected to normal vision. Written consent to participate was obtained from adult participants or from parents or guardians on behalf of child participants under  procedures approved by the Institutional Review Board of The Pennsylvania State University (#37946). The research was conducted according to the principles expressed in the Declaration of Helsinki. Participants were given credit or $10 per hour for their participation.

#### Experiment 1: Adults
30 adults (14 male, 16 female; age range: 18.7-23.9; mean age: 20.8 years, SD = X) participated in this study. The sample consisted of young adults recruited from the undergraduate psychology subject pool at the Pennsylvania State University.  One participant’s data was removed from analysis for failure to follow task instructions. Resulting in 29 adults 14 male, 15 female; age range: X; mean age: X years, SD = X) utilized for analysis.

#### Experiment 2: Children

31 children (19  female; age range: 5.2-8.6 years; mean age: 6.7 years (SD=1.0)) participated in the study. The sample consisted of children drawn from a database of families in Centre County, Pennsylvania. Children were excluded if they were born prematurely, had a history of serious visual or medical problems, epilepsy, or seizures. One participant's data (1045) was excluded due to incomplete data collection.

### Stimuli

The stimuli was generated on an iMac computer using MATLAB (R2013b) and Psychtoolbox (XXX). The display consisted of two side-by-side, time varying (1.2 Hz coherent/incoherent cycle) annular-shaped (18 deg outer/5 deg inner diameter) optic flow displays with a fixation dot centrally located between the two circular random dot kinematogram displays. One display depicted random (0% coherent) motion while the other depicted a radial or linear motion pattern at one of four fixed coherence levels. Adult and child participants viewed different coherence level profiles. Four runs were presented to the participant in a single visit with 2 runs at a speed of 2 deg/s and 2 runs at a speed of 8 deg/s presented in a **balanced random order**. Each of the 8 combinations of coherence patterns and coherence levels appeared once on the left display and once on the right display for a total of 16 conditions within a block. A method of constant stimuli was used, and condition order varied randomly within a block. Five blocks were completed within a single run resulting in 80 trials per run. Each trial had a 10 second response time limit.

### Procedures

Upon arrival at the laboratory, study and visit procedures were described and informed consent was obtained. Visual acuity was measured for each participant with the Snellen Visual Acuity chart. Participants were escorted into a dimly lit testing room and seated 60cm in front of the computer monitor. 

#### Experiment 1
Participants were instructed to fixate on the dot in the center of the display and to use their peripheral vision to discern which of the displays was exhibiting an optic flow pattern. They were informed about the 10 second response limit and that their response times were being recorded. Participants used a keyboard to make their decisions, pressing the “z” key to choose the left and the “/ or ?” key to choose the right. The four coherence levels used were 5%, 10%, 15%, and 20%. Participants were given the option to take a break half way through the experiment. 

#### Experiment 2
The experimenter remained in the testing room for the entire study.  Child observers fixated centrally and judged which side contained coherent motion, indicating their choice by verbalizing or pointing to the monitor. A practice session of 6-16 trials was used to teach the participants what to look for in the display for a given trial. The choice (left/right) was entered by the experimenter using a Sabrent game controller. Child participants viewed one of two coherence level profiles (20, 40, 60, 80%) or (15, 30, 45, 60%). The entire data collection session was video recorded. Participants were given the option to take a break after each run.

### Analysis

Each run generated an output file containing pattern type, coherence level, reaction time and accuracy for each trial. R (citation) scripts were were generated to clean and merge the data files prior to analysis. Statistical analysis and summary plots were generated using R Studio (citation). Repeated measures analysis of variance (ANOVA) was used to determine the effects of speed, pattern, and coherence. Prior to conducting statistical analyses, the individual percent correct by coherence, pattern and speed were plotted and visually evaluated. One adult participant (14) was eliminated from analysis for having chance or worse than chance performance even at the highest coherence levels.

### Results

#### Experiment 1

Are these data going to be re run with the new R code or is what is here acceptable?  
____  
Copied from Thesis -  rework  
  
In order to determine whether participants are faster to respond to one type of optic flow or another as predicted by prior EEG evidence, a mixed effects ANOVA with RT as the dependent variable and optic flow pattern (2 levels: radial, translational) was run. Since the study also varied coherence levels (4 levels: 5, 10, 15, and 20%) and speeds (2 levels: 2 deg/s, 8 deg/s) in a totally crossed design, these factors were included in the ANOVA as well. The effect of coherence was modeled as a single linear predictor equivalent to slope because prior literature and theory suggest that response functions are continuous. The ANOVA included a separate
random effect for each participant to account for the fact that reaction times vary widely across participants.  

The descriptive statistics, including means, standard errors of the means, and medians, for response time data across coherence, pattern, and speed are reported in Table 1. Response times decreased as coherence level increased from 0.05 (M = 3.90s) to 0.20 (M = 2.16s). There was also a greater mean response time to linear (M = 3.09s) than to radial flow (M = 2.81s). Response times were very similar for optic flow patterns delivered at 8 deg/s (M = 2.97s) and at 2 deg/s (M = 2.93s). The response time means are displayed in a boxplot in Figure 4. The trends that can be visualized in this graph are that mean response times were shorter at higher motion coherence levels and for radial optic flow patterns. No effect of speed can be identified. The ANOVAs run confirmed main effects of coherence, F (1, 455) = 229.84, p < 2e-16, and pattern, F (1, 455) = 10.55, p = 1.25e-3, and no main effect of speed, F (1, 455) = 0.15, p = 0.70. The ANOVA results indicate that alterations of the dependent variables coherence and pattern type have a significant
effect of the amount of time participants took to respond in the task. These main effects were predicted, but cannot be fully evaluated without looking at the interaction effects present.  

A significant two-way interaction was found between pattern and coherence, F (1, 455) = 39.27, p = 3.85e-10. This interaction indicates an effect of pattern, within the effect of coherence. In this scenario, an increase in coherence causes a drop in response time for both radial and linear patterns, but the effect is more extreme and the time decrease is more substantial for radial. In Figure 4, this interaction can be explained visually as a steeper decrease in response time means across coherence levels for radial than for linear optic flow patterns. There were no interaction effects found between speed and coherence or pattern and speed for the response time. Full ANOVA results for response time are listed in Table 3.  

The other experimental measure used to evaluate perceptual abilities in identifying optic flow patterns was percent correct. Just as spending less time in answering was an indication of how easy a certain pattern is to identify, so is percent correctly identified. To determine whether participants were more successful at identifying one type of another, with predictions again based on the same EEG evidence, a mixed effects ANOVA with percent correct as the dependent variable and pattern type, coherence level, and speed as the independent variables.  

For the percent correct data, the means, standard errors of the means, and medians across all conditions are given in Table 2. Success rates improved as the coherence level increased from 0.05 (M = 0.52) to 0.20 (M = 0.90). Success rates were found to be better for radial (M = 0.76) than for linear flow patterns (M = 0.72). There was little difference in success rates to flow patterns at 8 deg/s (M = 0.73) and 2 deg/s (M = 0.75). The trends that emerged from looking at the means were confirmed by the ANOVA. Main effects were found of coherence, F (1,471) = 423.42, p < 2e-16, and of pattern, F (1, 471) = 9.94, p = 1.72e-3, but not of speed, F (1, 471) = 3.26, p = 0.07. The success rates of each participant to each experimental condition are shown in Figure 3. Although each participant’s success rate is shown individually, the trends found in the data analysis are still evident. Success rates increase at higher coherence levels and success rates are on average higher to radial than linear optic flow. Again, these main effects cannot be sufficiently analyzed without exploring the interaction effects present.  

A significant interaction was found between pattern and coherence on participant success rates, F (1, 471) = 19.48, p = 1.26e-5, meaning that there was an effect of pattern within the effect of coherence. Participants were more successful at identifying optic flow at higher coherence levels regardless of pattern, but the degrees to which success rates increased varied between radial and linear. At low coherence levels (0.05) participants were more successful at detecting linear flow (M = 0.54) than radial flow (M=0.49) patterns. As coherence levels increased, participants showed a steeper rate of improvement at identifying radial than linear flow. At high coherence levels (0.20), participants were more successful at identifying radial (M=0.96) than translational (M=0.86) patterns. This interaction effect can be summarized as an increased sensitivity to radial flow patterns compared to linear flow patterns, at high coherence levels. In Figure 3, it is evident that at low coherence levels, participants have similar widespread success rates for both radial and translational. At high coherence levels, a larger cluster of
participants achieved perfect success rates (1.00) for radial than for translational, illustrating the interaction between coherence and pattern. Overall, the slopes of the percent correct lines are steeper for radial than for linear patterns. No other interactions were found to exist for percent correct results. Full ANOVA results for the effects of coherence, pattern, and speed on percent
correct are listed in Table 4.
____
#### Experiment 2


From Abstract:

We analyzed the proportion of correct responses and response times using generalized linear mixed effects modeling in R. As predicted, the proportion of correct judgments increased and the response times of correct judgements declined with increasing motion coherence. Fast optic flow patterns were perceived more reliably than slow, and radial patterns were perceived more reliably than linear patterns. Taken together the results suggest that school-age children's abilities to detect radial and linear optic flow patterns in noise are somewhat less precise than adults', although their biases toward faster radial patterns are adult-like. Combined with other prior EEG results, these data suggest that optic flow processing networks mature rapidly from infancy, but undergo less rapid, subtler change from mid-childhood to adulthood.
