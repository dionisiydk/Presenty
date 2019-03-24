Class {
	#name : #PtySearchItemTask,
	#superclass : #PtyItemsSelectionTask,
	#instVars : [
		'searchDesc',
		'searchField',
		'editTask',
		'onlyEditorViewArea'
	],
	#category : #'Presenty-ItemSelectionTasks'
}

{ #category : #testing }
PtySearchItemTask >> allowChangeParentViewAreaState [
	^true
]

{ #category : #execution }
PtySearchItemTask >> body [

	| item |
	searchField := searchDesc createField.
	searchField becomeActive.
	searchField on: PtyValueChanged send: #filterItems to: self.
		
	editTask := searchField createEditorBy: guide.
	
	guide addTask: [guide requestUserFor: editTask] named: 'InputFilterString'.	
	
	onlyEditorViewArea := guide viewArea.
					
	item := user select: itemsName from: items.
	
	^item

]

{ #category : #execution }
PtySearchItemTask >> filterItems [

	guide setUpContext: (editTask  parentLike: PtyForkTask) context.
	guide viewArea: onlyEditorViewArea.
	
	guide executeTask: ([
		self showFilteredItems	
	] asTaskNamed: 'FilterItemsTask')
]

{ #category : #'initialize-release' }
PtySearchItemTask >> initialize [ 
	super initialize.
	
	searchDesc := PtyFieldDesc new	
]

{ #category : #accessing }
PtySearchItemTask >> searchDesc [
	^ searchDesc
]

{ #category : #accessing }
PtySearchItemTask >> searchDesc: anObject [
	searchDesc := anObject
]

{ #category : #execution }
PtySearchItemTask >> showFilteredItems [

	| pattern filtered item |
	pattern := searchField value asLowercase.
	filtered := items select: [:each |
		each ptyUserSearchField asLowercase includesSubstring: pattern caseSensitive: true].					
	
	filtered ifEmpty: [^self].

	item := user select: itemsName from: filtered.

	context return: item
]
