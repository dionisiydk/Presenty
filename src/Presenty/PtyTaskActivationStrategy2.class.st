Class {
	#name : #PtyTaskActivationStrategy2,
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
PtyTaskActivationStrategy2 >> activateTask: aTask [

	| result |
	context := aTask createContextFor: self.

	shouldRememberTask ifTrue: [guide rememberTask: context].

	result := guide activateContext: context.

	shouldForgetCompleteTask ifTrue: [guide forgetTask: aTask].
	
	^result
	
	
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> allowSeparateItems [
	^ allowSeparateItems
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> allowSeparateItems: anObject [
	allowSeparateItems := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> context [
	^ context
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> context: anObject [
	context := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> createCopy [
	^self copy
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> embedCurrentAreaToParentOn: panelName [

	parentViewArea := parentViewArea createCopy.
	parentViewArea add: guide viewArea on: panelName.
	parentViewArea uiActions addAll: guide viewArea uiActions.
	guide viewArea uiActions removeAll.

	"guide viewArea separateForkItemsOn: parentViewArea"
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> guide [
	^ guide
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> guide: anObject [
	guide := anObject
]

{ #category : #'initialize-release' }
PtyTaskActivationStrategy2 >> initialize [ 
	super initialize.

	shouldRememberTask := false.	
	shouldForgetCompleteTask := false.
	shouldRestoreParentArea := true.
	allowSeparateItems := true
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> parent [
	^ parent
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> parentViewArea [
	^ parentViewArea
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> parentViewArea: anObject [
	parentViewArea := anObject
]

{ #category : #'morphic-menu' }
PtyTaskActivationStrategy2 >> populateSettingsMenu: aMenu for: aPrototype [

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
PtyTaskActivationStrategy2 >> prepareForEscapeTo: aTask fromContext: aTaskContext [ 

	aTask allowChangeParentViewAreaState ifFalse: [^self].
	
	aTaskContext shouldRestoreParentArea ifTrue: [^self].
	
	(aTaskContext isCreatedInContextOf: aTask) ifTrue: [^shouldRestoreParentArea := false].
	
	aTaskContext isChildrenShouldRestoreParentArea ifTrue: [^self].
	
	shouldRestoreParentArea := false
	
]

{ #category : #execution }
PtyTaskActivationStrategy2 >> saveViewArea [

	parentViewArea := guide viewArea.
	

]

{ #category : #execution }
PtyTaskActivationStrategy2 >> setUpNewViewArea [

	self subclassResponsibility 
]

{ #category : #execution }
PtyTaskActivationStrategy2 >> shareParentAreaWithCurrentRequests [

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
PtyTaskActivationStrategy2 >> shouldForgetCompleteTask [
	^ shouldForgetCompleteTask
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> shouldForgetCompleteTask: anObject [
	shouldForgetCompleteTask := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> shouldRememberTask [
	^ shouldRememberTask
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> shouldRememberTask: anObject [
	shouldRememberTask := anObject
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> shouldRestoreParentArea [
	^ shouldRestoreParentArea
]

{ #category : #accessing }
PtyTaskActivationStrategy2 >> shouldRestoreParentArea: anObject. [

	shouldRestoreParentArea := anObject
]
