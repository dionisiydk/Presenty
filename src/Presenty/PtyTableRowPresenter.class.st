Class {
	#name : #PtyTableRowPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'columns'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #accessing }
PtyTableRowPresenter >> columns [
	^ columns
]

{ #category : #accessing }
PtyTableRowPresenter >> columns: anObject [
	columns := anObject
]

{ #category : #'initialize-release' }
PtyTableRowPresenter >> initialize [ 
	super initialize.
	
	columns := OrderedCollection new.
]

{ #category : #accessing }
PtyTableRowPresenter >> rowIndex [

	^parent indexOfItem: self	
]

{ #category : #presentation }
PtyTableRowPresenter >> showCell: index with: anObject [

	| cell valuePresenter |
	
	valuePresenter := PtyLabelPresenter textNamed: anObject asString.
	cell := PtyPresentersDecorator named: 'tableCell' on: {valuePresenter}.
	cell style: 'column', index asString.

	self showItem: cell.
]

{ #category : #presentation }
PtyTableRowPresenter >> showCellWith: anObject at: aColumn [

	| cell valuePresenter |
	
	cell := PtyPresentersDecorator named: 'tableCell' on: {anObject preferredPreviewPresenter}.
	cell style: 'column', aColumn title asString.

	self showItem: cell.
]

{ #category : #presentation }
PtyTableRowPresenter >> showViewItems [

	columns withIndexDo: [:eachColumn :i | 

		[self showCellWith: (eachColumn valueFor: model) at: eachColumn]
			on: PtyObjectAspectRequest do: [:request | 
				
				(self respondsTo: request selector)
					ifTrue: [request resume: (self perform: request selector)]
					ifFalse: [request pass]
				
				]		
		].
]
