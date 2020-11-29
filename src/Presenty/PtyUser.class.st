Class {
	#name : #PtyUser,
	#superclass : #Object,
	#instVars : [
		'workplace'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #'instance creation' }
PtyUser class >> of: aWorkplace [

	^self new 
		workplace: aWorkplace 
]

{ #category : #requests }
PtyUser >> executeTask: requestedTask [
	
	| plannedTask |
	plannedTask := workplace planExecutionOf: requestedTask by: self.
	^plannedTask requestExecution
]

{ #category : #accessing }
PtyUser >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyUser >> workplace: anObject [
	workplace := anObject
]
