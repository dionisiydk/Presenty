Class {
	#name : #PtyViewAreaItem,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'panelName'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyViewAreaItem class >> bodyWith: aPresenter [ 

	^self presenter: aPresenter on: 'body'
]

{ #category : #'instance creation' }
PtyViewAreaItem class >> presenter: aPresenter on: panelName [

	^self new 
		presenter: aPresenter;
		panelName: panelName
]

{ #category : #accessing }
PtyViewAreaItem >> panelName [
	^ panelName
]

{ #category : #accessing }
PtyViewAreaItem >> panelName: anObject [
	panelName := anObject
]

{ #category : #accessing }
PtyViewAreaItem >> presenter [
	^ presenter
]

{ #category : #accessing }
PtyViewAreaItem >> presenter: anObject [
	presenter := anObject
]

{ #category : #presentation }
PtyViewAreaItem >> showOn: aView by: aGuide [

	| panel |
	panel := aView panelNamed: panelName.
	presenter context: aGuide context.
	presenter view ifNil: [aGuide preparePresenter: presenter].
	
	panel add: presenter view
]
