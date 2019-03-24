Class {
	#name : #PtyTaskConfigurationRequest,
	#superclass : #Exception,
	#instVars : [
		'task'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTaskConfigurationRequest class >> for: aTask [
	^self new 
		task: aTask
]

{ #category : #'instance creation' }
PtyTaskConfigurationRequest class >> for: taskClass named: aString [
	^self for: (taskClass named: aString)
]

{ #category : #'instance creation' }
PtyTaskConfigurationRequest class >> for: taskClass ofItems: itemsName [
 
	^self for: (taskClass new itemsName: itemsName)
]

{ #category : #signalling }
PtyTaskConfigurationRequest class >> signalFor: aTask [
	| request |
	request := self for: aTask.
	^request signal
]

{ #category : #accessing }
PtyTaskConfigurationRequest >> defaultAction [

	self resume
]

{ #category : #testing }
PtyTaskConfigurationRequest >> handles: anException [

	(anException isKindOf: self class) ifFalse: [^false].
	
	^anException task isKindOfTask: task
]

{ #category : #accessing }
PtyTaskConfigurationRequest >> task [
	^ task
]

{ #category : #accessing }
PtyTaskConfigurationRequest >> task: anObject [
	task := anObject
]
