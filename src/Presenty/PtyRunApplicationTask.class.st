Class {
	#name : #PtyRunApplicationTask,
	#superclass : #PtyTask,
	#instVars : [
		'mainTask'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyRunApplicationTask class >> on: aTask [

	^self new 
		mainTask: aTask 
]

{ #category : #testing }
PtyRunApplicationTask >> allowChangeParentViewAreaState [
	^false
]

{ #category : #execution }
PtyRunApplicationTask >> body [ 

	context := nil.
	guide taskNavigator clearTasks.
	guide rememberTask: guide context.
	guide context viewAreaActivator parentActivator: nil.
	
	guide requestUserFor: mainTask 
]

{ #category : #accessing }
PtyRunApplicationTask >> defaultActivationStrategy [

	^PtySeparatedTaskActivationStrategy new 
		shouldRememberTask: true;
		areaActivator: PtyNewWindowActivator new;
		yourself 
]

{ #category : #accessing }
PtyRunApplicationTask >> mainTask [
	^ mainTask
]

{ #category : #accessing }
PtyRunApplicationTask >> mainTask: anObject [
	mainTask := anObject
]
