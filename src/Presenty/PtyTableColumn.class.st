Class {
	#name : #PtyTableColumn,
	#superclass : #Object,
	#instVars : [
		'title',
		'valueBlock'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #'instance creation' }
PtyTableColumn class >> title: aString block: aBlock [
	^self new
		title: aString;
		valueBlock: aBlock
]

{ #category : #presentation }
PtyTableColumn >> preferredPreviewPresenter [

	^PtyPresentersDecorator withStyle: 'headerFor', title
]

{ #category : #accessing }
PtyTableColumn >> title [
	^ title
]

{ #category : #accessing }
PtyTableColumn >> title: anObject [
	title := anObject
]

{ #category : #accessing }
PtyTableColumn >> valueBlock [
	^ valueBlock
]

{ #category : #accessing }
PtyTableColumn >> valueBlock: anObject [
	valueBlock := anObject
]

{ #category : #accessing }
PtyTableColumn >> valueFor: model [

	^valueBlock value: model
]
