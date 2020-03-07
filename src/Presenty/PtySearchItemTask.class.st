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
		
	editTask := searchField createEditorBy: worker.
	
	worker addTask: [worker requestUserFor: editTask] named: 'InputFilterString'.	
	
	onlyEditorViewArea := worker viewArea.
					
	item := user select: itemsName from: items.
	
	^item

]

{ #category : #execution }
PtySearchItemTask >> filterItems [

	worker setUpContext: (editTask  parentLike: PtyForkTask) context.
	worker viewArea: onlyEditorViewArea.
	
	worker executeTask: ([
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
