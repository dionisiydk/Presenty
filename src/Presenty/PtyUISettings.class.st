Class {
	#name : #PtyUISettings,
	#superclass : #Object,
	#instVars : [
		'viewPrototypes',
		'userActionPrototypes',
		'taskPrototypes'
	],
	#category : #'Presenty-Core'
}

{ #category : #building }
PtyUISettings >> appropriateTaskLike: aTask inContextOf:  aTaskContext [
	| prototype newTask |
	
	aTask context: aTaskContext.
	
	prototype := taskPrototypes prototypeFor: aTask.
	newTask := prototype newInstance.	
	newTask 
		readFromSample: aTask;
		prototype: prototype.
		
	PtyTaskConfigurationRequest signalFor: newTask.

	^newTask
]

{ #category : #building }
PtyUISettings >> appropriateViewFor: aPresenter [
	| prototype view |

	prototype := viewPrototypes prototypeFor: aPresenter.
	view := prototype newInstance.
	view buildContext: (PtyViewBuildContext presenter: aPresenter prototype: prototype).
	^view
]

{ #category : #building }
PtyUISettings >> createViewFor: aPresenter [
	aPresenter createViewBy: self.
	aPresenter connectUserActionsBy: self
]

{ #category : #'initialize-release' }
PtyUISettings >> initialize [ 
	super initialize.
	
	viewPrototypes := PtyPrototypesManager with: PtyViewPrototypeFactory new.
	userActionPrototypes := PtyPrototypesManager with: PtyUserActionPrototypeFactory new.
	taskPrototypes := PtyPrototypesManager with: PtyStreetUserPrototypeFactory new
]

{ #category : #accessing }
PtyUISettings >> taskPrototypes [
	^ taskPrototypes
]

{ #category : #accessing }
PtyUISettings >> taskPrototypes: anObject [
	taskPrototypes := anObject
]

{ #category : #accessing }
PtyUISettings >> userActionPrototypes [
	^ userActionPrototypes
]

{ #category : #accessing }
PtyUISettings >> userActionPrototypes: anObject [
	userActionPrototypes := anObject
]

{ #category : #accessing }
PtyUISettings >> viewPrototypes [
	^ viewPrototypes
]

{ #category : #accessing }
PtyUISettings >> viewPrototypes: anObject [
	viewPrototypes := anObject
]
