Class {
	#name : #PtyWorkSession,
	#superclass : #Object,
	#instVars : [
		'parentSession',
		'workflows'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyWorkSession >> addNewWorkflow [

	^self addWorkflow: (PtyWorkflow in: self)
]

{ #category : #accessing }
PtyWorkSession >> addWorkflow: aWorkflow [
	^workflows add: aWorkflow
]

{ #category : #accessing }
PtyWorkSession >> currentTasks [
	^workflows flatCollect: [ :each | each currentTasks ]
]

{ #category : #initialization }
PtyWorkSession >> initialize [ 
	super initialize.
	
	workflows := OrderedCollection new
]

{ #category : #accessing }
PtyWorkSession >> parentSession [
	^ parentSession
]

{ #category : #accessing }
PtyWorkSession >> parentSession: anObject [
	parentSession := anObject
]

{ #category : #controlling }
PtyWorkSession >> postCopy [
	super postCopy.
	
	workflows := workflows copy
]

{ #category : #controlling }
PtyWorkSession >> revertStateTo: aWorkSession startingAt: initialWorkflow [
	
	| newWorkflows |
	newWorkflows := OrderedCollection new.
	aWorkSession workflows do: [ :requiredWorkflow | | requiredChildren |
		requiredChildren := self workflowsSpawnedFrom: requiredWorkflow.
		newWorkflows add: requiredWorkflow.
		newWorkflows addAll: requiredChildren.
		workflows remove: requiredWorkflow ifAbsent: [].
		workflows removeAllFoundIn: requiredChildren].
		
	workflows := newWorkflows.
]

{ #category : #controlling }
PtyWorkSession >> spawnNew [

	| newSession |
	newSession := self copy.
	newSession parentSession: self.
	^newSession

	
]

{ #category : #accessing }
PtyWorkSession >> workflowWith: aTask [
	^workflows detect: [ :each | each includesTask: aTask ]
]

{ #category : #accessing }
PtyWorkSession >> workflows [
	^ workflows
]

{ #category : #accessing }
PtyWorkSession >> workflows: anObject [
	workflows := anObject
]

{ #category : #accessing }
PtyWorkSession >> workflowsSpawnedFrom: parentWorkflow [

	^workflows select: [ :existingWorkflow | 
		parentWorkflow forkedWorkflows anySatisfy: [ :requiredWorkflow |
			existingWorkflow = requiredWorkflow or: [ 
				existingWorkflow isSpawnedFrom: requiredWorkflow ]]]
]
