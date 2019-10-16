Class {
	#name : #PtyTaskContext,
	#superclass : #Object,
	#instVars : [
		'activationPoint',
		'task',
		'continuation',
		'activation',
		'taskItems'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTaskContext class >> of: aTask [

	^self new 
		task: aTask
		
]

{ #category : #activation }
PtyTaskContext >> activateBy: aGuide [ 
	
	| activationRequest result |
	activationPoint currentTasks: aGuide currentTasks copy.
	aGuide addActiveTask: self.
	
	activationRequest := self prepareActivationRequest.	
	
	result := activationRequest executeBy: aGuide inContext: self.
		
	aGuide currentTasks: activationPoint currentTasks.
	
	^result
]

{ #category : #accessing }
PtyTaskContext >> activation [
	^ activation
]

{ #category : #accessing }
PtyTaskContext >> activation: anActivationStrategy [
	activation := anActivationStrategy
	
]

{ #category : #accessing }
PtyTaskContext >> activationPoint [
	^ activationPoint
]

{ #category : #accessing }
PtyTaskContext >> activationPoint: anObject [
	activationPoint := anObject
]

{ #category : #controlling }
PtyTaskContext >> changeParentAreaFor: aViewAreaPresenter [ 

	activation shouldRestoreParentArea ifTrue: [^self].
	
	activation parentViewArea: aViewAreaPresenter
	
]

{ #category : #accessing }
PtyTaskContext >> continuation [
	^ continuation
]

{ #category : #accessing }
PtyTaskContext >> continuation: anObject [
	continuation := anObject
]

{ #category : #controlling }
PtyTaskContext >> copyAsNewReturn [

	| newContext |
	newContext := self copy.
	newContext activation: activation copy.
	^newContext.
]

{ #category : #activation }
PtyTaskContext >> createNewContextFor: aPtyTask [ 

	| newContext |
	newContext := PtyTaskContext of: aPtyTask.
	newContext activationPoint: (PtyTaskActivationPoint createdFrom: self).
	^newContext
]

{ #category : #testing }
PtyTaskContext >> hasParentLike: taskClass [

	task context ifNil: [^false].
	
	(task parent isKindOf: taskClass) ifTrue: [^true].
	
	^task context hasParentLike: taskClass 
]

{ #category : #testing }
PtyTaskContext >> isChildrenShouldRestoreParentArea [
	^task isChildrenShouldRestoreParentArea
]

{ #category : #testing }
PtyTaskContext >> isCreatedInContextOf: aTask [

	task == aTask ifTrue: [^true].
	
	task context ifNil: [^false].
	
	^task context isCreatedInContextOf: aTask
]

{ #category : #testing }
PtyTaskContext >> isDerivedFrom: aTaskContext [ 
	self == aTaskContext ifTrue: [^true].
	task context == aTaskContext ifTrue: [^true].
	
	^false
]

{ #category : #accessing }
PtyTaskContext >> parent [

	^task context
]

{ #category : #accessing }
PtyTaskContext >> parentViewArea [

	^activation parentViewArea 
]

{ #category : #accessing }
PtyTaskContext >> parentViewArea: aViewAreaPresenter [  
	activation parentViewArea: aViewAreaPresenter 
]

{ #category : #controlling }
PtyTaskContext >> prepareActivationForReturnFrom: aTaskContext [

	activation prepareForEscapeTo: task fromContext: aTaskContext
]

{ #category : #controlling }
PtyTaskContext >> prepareActivationRequest [
	^Continuation currentDo: [ :cc | 	continuation := cc.	task activationRequest ].
	
]

{ #category : #controlling }
PtyTaskContext >> prepareReturnContextTo: aTaskContext [

	| newContext |
	newContext := aTaskContext copyAsNewReturn.

	newContext prepareActivationForReturnFrom: self.

	^newContext
]

{ #category : #printing }
PtyTaskContext >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	task printOn: aStream.
	aStream nextPut: $)
]

{ #category : #controlling }
PtyTaskContext >> resumeFor: anActivationRequest [
	anActivationRequest task: task.
	continuation value: anActivationRequest 
]

{ #category : #controlling }
PtyTaskContext >> return: resultObject [
	self resumeFor: (PtyTaskReturnRequest value: resultObject)
]

{ #category : #testing }
PtyTaskContext >> shouldRestoreParentArea [ 
	^activation shouldRestoreParentArea 
]

{ #category : #accessing }
PtyTaskContext >> task [
	^ task
]

{ #category : #accessing }
PtyTaskContext >> task: anObject [
	task := anObject
]

{ #category : #accessing }
PtyTaskContext >> taskCallChain [
	| parents current |

	parents := OrderedCollection with: task.
	current := task.
	[(current := current context) notNil] whileTrue: [parents add: (current := current task)].
	^parents
]

{ #category : #accessing }
PtyTaskContext >> taskClass [
	^task class
]

{ #category : #accessing }
PtyTaskContext >> viewAreaActivator [

	^activation areaActivator
]
