Class {
	#name : #PtyExplicitPresenterFactory,
	#superclass : #PtyPresenterFactory,
	#instVars : [
		'presenterClass',
		'presenterName',
		'presenterStyle'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyExplicitPresenterFactory class >> with: aPresenterClass [
	^self new 
		presenterClass: aPresenterClass 
]

{ #category : #accessing }
PtyExplicitPresenterFactory >> presenterClass [
	^ presenterClass
]

{ #category : #accessing }
PtyExplicitPresenterFactory >> presenterClass: anObject [
	presenterClass := anObject
]

{ #category : #accessing }
PtyExplicitPresenterFactory >> presenterName [
	^ presenterName
]

{ #category : #accessing }
PtyExplicitPresenterFactory >> presenterName: anObject [
	presenterName := anObject
]

{ #category : #'presenters creation' }
PtyExplicitPresenterFactory >> presenterOn: aModelObject for: aTask [

	| presenter |
	presenter := presenterClass named: presenterName on: aModelObject.
	presenter style: presenterStyle.
	^presenter
]

{ #category : #accessing }
PtyExplicitPresenterFactory >> presenterStyle [
	^ presenterStyle
]

{ #category : #accessing }
PtyExplicitPresenterFactory >> presenterStyle: anObject [
	presenterStyle := anObject
]
