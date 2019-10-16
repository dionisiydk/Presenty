Class {
	#name : #PtyTaskActivationStrategy,
	#superclass : #Object,
	#instVars : [
		'guide',
		'context',
		'parent',
		'parentViewArea',
		'shouldRememberTask',
		'shouldForgetCompleteTask',
		'shouldRestoreParentArea',
		'allowSeparateItems'
	],
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyTaskActivationStrategy >> activateTask: aTask [

	| result |
	context := aTask createContextFor: self.

	shouldRememberTask ifTrue: [guide rememberTask: context].

	result := guide activateContext: context.

	shouldForgetCompleteTask ifTrue: [guide forgetTask: aTask].
	
	^result
	
	
]

{ #category : #accessing }
PtyTaskActivationStrategy >> allowSeparateItems [
	^ allowSeparateItems
]

{ #category : #accessing }
PtyTaskActivationStrategy >> allowSeparateItems: anObject [
	allowSeparateItems := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy >> context [
	^ context
]

{ #category : #accessing }
PtyTaskActivationStrategy >> context: anObject [
	context := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy >> createCopy [
	^self copy
]

{ #category : #accessing }
PtyTaskActivationStrategy >> embedCurrentAreaToParentOn: panelName [

	parentViewArea := parentViewArea createCopy.
	parentViewArea add: guide viewArea on: panelName.
	parentViewArea uiActions addAll: guide viewArea uiActions.
	guide viewArea uiActions removeAll.

	"guide viewArea separateForkItemsOn: parentViewArea"
]

{ #category : #accessing }
PtyTaskActivationStrategy >> guide [
	^ guide
]

{ #category : #accessing }
PtyTaskActivationStrategy >> guide: anObject [
	guide := anObject
]

{ #category : #'initialize-release' }
PtyTaskActivationStrategy >> initialize [ 
	super initialize.

	shouldRememberTask := false.	
	shouldForgetCompleteTask := false.
	shouldRestoreParentArea := true.
	allowSeparateItems := true
]

{ #category : #accessing }
PtyTaskActivationStrategy >> parent [
	^ parent
]

{ #category : #accessing }
PtyTaskActivationStrategy >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy >> parentViewArea [
	^ parentViewArea
]

{ #category : #accessing }
PtyTaskActivationStrategy >> parentViewArea: anObject [
	parentViewArea := anObject
]

{ #category : #'morphic-menu' }
PtyTaskActivationStrategy >> populateSettingsMenu: aMenu for: aPrototype [

	#(#shouldRememberTask #shouldForgetCompleteTask #shouldRestoreParentArea #allowSeparateItems)
		do: [ :eachOption | 
			aMenu
				addToggle: eachOption
				target:  (aPrototype proxyForSample: self)
				selector: eachOption asMutator
				getStateSelector: eachOption
				argumentList: {((self perform: eachOption) not)} ]
]

{ #category : #execution }
PtyTaskActivationStrategy >> prepareForEscapeTo: aTask fromContext: aTaskContext [ 

	aTask allowChangeParentViewAreaState ifFalse: [^self].
	
	aTaskContext shouldRestoreParentArea ifTrue: [^self].
	
	(aTaskContext isCreatedInContextOf: aTask) ifTrue: [^shouldRestoreParentArea := false].
	
	aTaskContext isChildrenShouldRestoreParentArea ifTrue: [^self].
	
	shouldRestoreParentArea := false
	
]

{ #category : #execution }
PtyTaskActivationStrategy >> saveViewArea [

	parentViewArea := guide viewArea.
	

]

{ #category : #execution }
PtyTaskActivationStrategy >> setUpNewViewArea [

	self subclassResponsibility 
]

{ #category : #execution }
PtyTaskActivationStrategy >> shareParentAreaWithCurrentRequests [

	| anotherForkedTasks connectedTasks |
	anotherForkedTasks := (guide currentTasksLike: context).
	connectedTasks := anotherForkedTasks reject: [:each | 
		each task hasParentSuchThat: [:p | p shouldSeparateForkTasks ]
	].
	
	connectedTasks do: [:each | 
		(guide currentTasks select: [:eachTarget | eachTarget isCreatedInContextOf: each task])
			do: [:eachTarget |	eachTarget activation parentViewArea: parentViewArea]]
]

{ #category : #accessing }
PtyTaskActivationStrategy >> shouldForgetCompleteTask [
	^ shouldForgetCompleteTask
]

{ #category : #accessing }
PtyTaskActivationStrategy >> shouldForgetCompleteTask: anObject [
	shouldForgetCompleteTask := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy >> shouldRememberTask [
	^ shouldRememberTask
]

{ #category : #accessing }
PtyTaskActivationStrategy >> shouldRememberTask: anObject [
	shouldRememberTask := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy >> shouldRestoreParentArea [
	^ shouldRestoreParentArea
]

{ #category : #accessing }
PtyTaskActivationStrategy >> shouldRestoreParentArea: anObject. [

	shouldRestoreParentArea := anObject
]
