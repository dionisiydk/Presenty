Class {
	#name : #PtyViewAreaStubActivator,
	#superclass : #PtyViewAreaActivator,
	#instVars : [
		'stubPanel'
	],
	#category : #'PresentyTests-Acceptance'
}

{ #category : #activation }
PtyViewAreaStubActivator >> activateViewportBy: aGuide [

	^baseArea view
]

{ #category : #activation }
PtyViewAreaStubActivator >> prepareViewportBy: aGuide [

	baseArea := PtyViewAreaPresenter named: 'stubViewArea'.
	baseArea guide: aGuide.
	baseArea context: aGuide context.
	aGuide preparePresenter: baseArea.


]
