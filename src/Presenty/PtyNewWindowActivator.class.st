Class {
	#name : #PtyNewWindowActivator,
	#superclass : #PtyViewAreaActivator,
	#instVars : [
		'window'
	],
	#category : #'Presenty-Core'
}

{ #category : #activation }
PtyNewWindowActivator >> activateViewportBy: aGuide [

	window isInWorld ifFalse: [window openInWorld].
	^baseArea view
]

{ #category : #activation }
PtyNewWindowActivator >> createWindow [ 

	window := SystemWindow new.
	window addMorph: baseArea view frame: (0@0 corner: 1@1).	
		

]

{ #category : #activation }
PtyNewWindowActivator >> prepareViewportBy: aGuide [

	baseArea := PtyViewAreaPresenter named: 'windowViewArea'.
	baseArea guide: aGuide.
	baseArea context: aGuide context.
	aGuide preparePresenter: baseArea.

	self createWindow
]
