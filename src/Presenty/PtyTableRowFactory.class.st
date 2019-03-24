Class {
	#name : #PtyTableRowFactory,
	#superclass : #PtyPresenterFactory,
	#instVars : [
		'columns'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyTableRowFactory class >> withColumns: columnsArray [

	^self new 
		columns: columnsArray 
]

{ #category : #accessing }
PtyTableRowFactory >> columns [
	^ columns
]

{ #category : #accessing }
PtyTableRowFactory >> columns: anObject [
	columns := anObject
]

{ #category : #'presenters creation' }
PtyTableRowFactory >> presenterOn: aModelObject for: aTask [

	| row |
	row := PtyTableRowPresenter on: aModelObject.
	row columns: columns.
	^row
]
