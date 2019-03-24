Class {
	#name : #PtyInlinedAreaActivator,
	#superclass : #PtyViewAreaActivator,
	#category : #'Presenty-Core'
}

{ #category : #activation }
PtyInlinedAreaActivator >> activateViewportBy: aGuide [

	^parentActivator activateViewportBy: aGuide 
]

{ #category : #activation }
PtyInlinedAreaActivator >> hasPreparedViewport [ 
	^parentActivator hasPreparedViewport 
]

{ #category : #activation }
PtyInlinedAreaActivator >> prepareViewportBy: aGuide [

	parentActivator prepareViewportBy: aGuide 
]

{ #category : #activation }
PtyInlinedAreaActivator >> show: aViewAreaPresenter by: aGuide [

	parentActivator show: aViewAreaPresenter by: aGuide 
]
