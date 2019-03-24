Class {
	#name : #PtyItemsPage,
	#superclass : #Object,
	#instVars : [
		'number',
		'contents'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyItemsPage class >> number: aNumber [ 

	^self new 
		number: aNumber 
]

{ #category : #accessing }
PtyItemsPage >> add: anObject [

	contents add: anObject 
]

{ #category : #accessing }
PtyItemsPage >> contents [
	^ contents
]

{ #category : #accessing }
PtyItemsPage >> contents: anObject [
	contents := anObject
]

{ #category : #'initialize-release' }
PtyItemsPage >> initialize [ 
	super initialize.
	
	contents := OrderedCollection new
]

{ #category : #accessing }
PtyItemsPage >> itemsCount [
	^contents size
]

{ #category : #accessing }
PtyItemsPage >> number [
	^ number
]

{ #category : #accessing }
PtyItemsPage >> number: anObject [
	number := anObject
]

{ #category : #presentation }
PtyItemsPage >> preferredPreviewPresenter [ 

	| numberLabel |
	numberLabel := PtySimpleLabelPresenter on: number asString withStyle: #pageNumber.
	^PtyPresentersDecorator on: {numberLabel} withStyle: #itemsPage
]
