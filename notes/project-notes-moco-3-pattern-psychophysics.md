# project-notes-moco-3-pattern-psychophysics

This is the project notes file for the moco-3-pattern-psychophysics project.  
Databrary volume: [Motion Coherence Thresholds for Child Participants Viewing Linear and Radial Patterns of Optic Flow](https://nyu.databrary.org/volume/218)  
Box data located at: [child-laminar-radial](https://psu.app.box.com/files/0/f/6187178733/child-laminar-radial)  

## Goal
- collect data from 25 children 5-8 yrs old.
- compare child with previously collected adult data  

## 2016-08-05-10:59

- 26 child participants completed  
- 4 more participants are scheduled for 8/9/16  
- SRCD abstract is in progress using 20 participants to be submitted on 8/8/16  

## 2016-05-02-11:12
- add data to github.
	- initial [data](https://github.com/gilmore-lab/moco-3-pattern-psychophysics/tree/master/child-laminar-radial/data) and 4yo data is added to [data/pilot](https://github.com/gilmore-lab/moco-3-pattern-psychophysics/tree/master/child-laminar-radial/data/pilot)

## 2016-04-29-13:00
- add video data to box: /b-gilmore-lab-group Shared/gilmore-lab/projects/optic-flow/optic-flow-psychophysics/projects/moco-3-pattern-psychophysics/child-laminar-radial/data/video 	

## 2016-04-26-10:00
- create log spacing between .1 and .6
  - x = log10(.1)
  - y = log10(.6)
  - z = linspace(x,y,4) = [-1.000 -0.7406 -0.4812 -0.2218]   
  - a = power(10,z) = [0.1000 0.1817 0.3302 0.6000]
  
 log spacing between .1 and .6 = [0.1000 0.1817 0.3302 0.6000]


## 2016-04-07-10:47
- Shivani and Raya have been tasked with figuring out 4 points between .1 and .6 using log spacing.

## 2016-04-06
- Databrary volume created [moco-2pat-child-psychophysics](https://nyu.databrary.org/volume/218)
- videos and .csv files still need to be uploaded to Databrary

- linspace(.1, .6, 4) = .1000, .2667, .4333, .6000

## 2016-04-02
- collect data from participants 1059 (5yo) and 1060 (6yo).
- had participants point and ARS entered the answers.
- The dot display is too light to be seen on the camera. Only the fixation point may be seen.

## 2016-03-31
- meeting - plotted first dataset
- To Do:
  - create databrary volume
  - figure out 4 points between .1 and .6 using even spacing (linspace in matlab) and on the log scale
  - work on automating code
  
## 2016-03-15-10:00
- pilot 4yo participant numbr 1048
  - participant verbalized or pointed to the chosen answer
  - researcher used game contorller to enter responses
  - 2 blocks 2,8
  - very fidgety participant - needed a break before the block was complete
  - did not use black cloth around the table 
  - light at 100%
  - Only the fixation dot could be seen on the monitor.
  - brighter video, but add additional light next time. 
  - blocks took ~ 20 min each - battery was changed after each block
- Very difficulty to test 4yo. Very fidgety, can't sit still, study not interesting enough.
  
  
  
## 2016-03-14-17:00
- pilot 4yo participant number 1046
   - participant used game controller
   - 4 blocks 2,8,2,8 
   - videos too dark - next time do not use black cloth around the table
 
## 2016-02-26-13:45
- Set up go pro camera with light under table and ipad
- Take video to see how long a new battery lasts
 Write procedure for setting up camera [GoPro instructions](notes/go-pro-instructions.md)
- Write participant instructions including instructions on how to use each input method [Participant Instructions](notes/moco-3pat-psychophysics-participant-instructions.md)

### To Do
- Review written procedures


## 2016-02-25-13:05
- Set up go pro camera with ipad to look for best view

### To Do
- Write procedure for setting up camera.  
- Write instructions for utilizing the keyboard/game controller and pointing. 
- Work on code to:  
   - use keyboard for 'p' and 'esc' when the game controller is being used.
   - have different keys work for different parts of the stimuli:
      - dot display: Lkey, Rkey, esckey, Pkey
      - blank screen: spkey, esckey
      - fixation dot: spkey, esckey
   
## 2016-02-18-12:45
- Meeting: Rick, Andrea, Raya, Shivani, Karina  
- Reviewed changes to code  
- Discussed options for piloting study  
   - set up camera (Rick will get the Go Pro to the lab) - determine camera angle  
   - acquire light for in the room that has a dimmer  
   - maybe have young participants point to the screen and have the experimenter press the button  
- Write procedure for setting up camera. Create new protocol. 
- Write instructions for utilizing having the participant point instead of using the keyboard/game controller. This should be part of the existing protocol [moco-3-pattern-psychophysics-experiment-instructions](gilmore-lab/moco-3-pattern-psychophysics/moco-3-pattern-psychophysics-experiment-instructions.md)   
  	
## 2016-02-18-10:00
- ars17 limited the allowable of key responses to the defined esckey, pkey, lkey, rkey, and spkey. This works for the keyboard and the game controller
	- issues - the spkey works during the dot display and it pressed logs a '0' 
- fixed the exiting out of the block/trial loop so the end of the study does not sound like an error.

## 2016-01-27-16:00
- pilot study 7 yo M

- Accept any key input response
- Script froze - no output .csv files were generated
- problems keeping fingers on the correct buttons
- more light needed

## 2016-01-20-09:00
- Completed updating instructions to include filenaming conventions and updating images 

## 2016-01-19-11:30
- Rename the folders where the .mat files are to the following:  
	- child_2deg/s_output > obj-2degPs-child.mat    v = 2 deg/s   coherence = [.2 .4 .6. 8]  
	- child_8deg/s_output > obj-8degPs-child.mat    v = 8 deg/s   coherence = [.2 .4 .6. 8]  	- 2 deg/s output-adult > obj_2degPs.mat	     v = 2 deg/s    coherence = [.05 .10 .15 .20]  
 	- 8 deg/s output-adult > obj_8degPs.mat	     v = 8 deg/s    coherence = [.05 .10 .15 .20] 

## 2016-01-05-12:00
- Alter matlab code rdkMain.m, objSet.m, and added script inputDevice() to allow additional input devices to be used.
- Sabarent 12 button USB game pad may now be used.

## 2015-12-17-10:40

- ars17 finished updating protocol instrutions and adding images


## 2015-09-23-12:10

- ars17 created this project notes file and pushed it to GitHub.






