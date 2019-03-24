Class {
	#name : #PtyViewAreaActivator,
	#superclass : #Object,
	#instVars : [
		'taskActivation',
		'baseArea',
		'parentActivator'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyViewAreaActivator class >> for: aTaskActivationStrategy [

	^self new 
		taskActivation: aTaskActivationStrategy
]

{ #category : #accessing }
PtyViewAreaActivator >> baseArea [
	^ baseArea
]

{ #category : #accessing }
PtyViewAreaActivator >> baseArea: anObject [
	baseArea := anObject
]

{ #category : #testing }
PtyViewAreaActivator >> hasPreparedViewport [ 
	^baseArea notNil 
]

{ #category : #accessing }
PtyViewAreaActivator >> parentActivator [
	^ parentActivator
]

{ #category : #accessing }
PtyViewAreaActivator >> parentActivator: anObject [
	parentActivator := anObject
]

{ #category : #accessing }
PtyViewAreaActivator >> rootActivator [

	parentActivator ifNil: [^self].
	
	^parentActivator rootActivator 
]

{ #category : #activation }
PtyViewAreaActivator >> show: aViewAreaPresenter by: aGuide [

	baseArea view clear.
	aGuide preparePresenter: aViewAreaPresenter.
	baseArea view add: aViewAreaPresenter view
]

{ #category : #accessing }
PtyViewAreaActivator >> taskActivation [
	^ taskActivation
]

{ #category : #accessing }
PtyViewAreaActivator >> taskActivation: anObject [
	taskActivation := anObject
]

{ #category : #activation }
PtyViewAreaActivator >> translateViewportBy: aTranslator [

	parentActivator ifNil: [^baseArea view translateContentBy: aTranslator].
	
	^parentActivator translateViewportBy: aTranslator 
]
