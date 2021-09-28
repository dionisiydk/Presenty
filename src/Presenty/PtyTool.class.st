Class {
	#name : #PtyTool,
	#superclass : #Object,
	#instVars : [
		'targetTask',
		'panel',
		'workflow',
		'components'
	],
	#category : #'Presenty-Tools'
}

{ #category : #testing }
PtyTool class >> isAbstract [ 
	^self = PtyTool 
]

{ #category : #controlling }
PtyTool >> activateOnPanel [
	self subclassResponsibility 
]

{ #category : #controlling }
PtyTool >> attachToPanel [

	panel := targetTask controlPanel.
	panel addTool: self
]

{ #category : #accessing }
PtyTool >> components [
	^ components
]

{ #category : #accessing }
PtyTool >> components: anObject [
	components := anObject
]

{ #category : #controlling }
PtyTool >> detachFromPanel [

	panel removeTool: self.
	panel := nil
]

{ #category : #initialization }
PtyTool >> initialize [ 
	super initialize.
	
	components := OrderedCollection new
]

{ #category : #testing }
PtyTool >> isPanel [ 
	^false
]

{ #category : #accessing }
PtyTool >> panel [
	^ panel
]

{ #category : #accessing }
PtyTool >> panel: aPanel [

	panel := aPanel
]

{ #category : #accessing }
PtyTool >> targetTask [
	^ targetTask
]

{ #category : #accessing }
PtyTool >> targetTask: anObject [
	targetTask := anObject
]

{ #category : #accessing }
PtyTool >> workflow [
	^ workflow
]

{ #category : #accessing }
PtyTool >> workflow: anObject [
	workflow := anObject
]
