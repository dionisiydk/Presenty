Class {
	#name : #PtyNewAreaActivator,
	#superclass : #PtyViewAreaActivator,
	#category : #'Presenty-Core'
}

{ #category : #activation }
PtyNewAreaActivator >> activateViewportBy: aGuide [

	| viewport |
	viewport := parentActivator activateViewportBy: aGuide.

	(viewport submorphs readStream upTo: baseArea view) do: #delete.
	
	viewport add: baseArea view.	
		
	^baseArea view
	
]

{ #category : #activation }
PtyNewAreaActivator >> prepareViewportBy: aGuide [

	parentActivator hasPreparedViewport ifFalse: [parentActivator prepareViewportBy: aGuide].

	baseArea := PtyViewAreaPresenter named: 'baseViewArea'.
	baseArea context: aGuide context.
	aGuide preparePresenter: baseArea.
	
	
]
