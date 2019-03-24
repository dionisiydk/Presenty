Class {
	#name : #PtyModalAreaActivator,
	#superclass : #PtyViewAreaActivator,
	#category : #'Presenty-Core'
}

{ #category : #activation }
PtyModalAreaActivator >> activateViewportBy: aGuide [

	| viewport |
	viewport := parentActivator activateViewportBy: aGuide.	
		
	(viewport submorphs includes: baseArea view) 
		ifTrue: [(viewport submorphs readStream upTo: baseArea view) do: #delete.]
		ifFalse: [
			"(aView submorphs includes: blockedViewArea view)
				ifFalse: [blockedViewArea activateOn: aView]."
							
			viewport add: baseArea view].
	
	baseArea view
			position: viewport position;
			extent: viewport extent.
	baseArea view comeToFront.
	
	^baseArea view
]

{ #category : #activation }
PtyModalAreaActivator >> prepareViewportBy: aGuide [

	parentActivator hasPreparedViewport ifFalse: [parentActivator prepareViewportBy: aGuide].
	
	baseArea := PtyViewAreaPresenter named: 'modalViewArea'.
	baseArea context: aGuide context.
	baseArea guide: aGuide.
	
	aGuide preparePresenter: baseArea.
	baseArea view
			disableTableLayout: true;
			cornerStyle: #square
]
