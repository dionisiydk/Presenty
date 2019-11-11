Class {
	#name : #PtyItemsNavigationTask,
	#superclass : #PtyItemsSelectionTask,
	#instVars : [
		'needsFirstSelection',
		'listTask',
		'selectedItem'
	],
	#category : #'Presenty-ItemSelectionTasks'
}

{ #category : #execution }
PtyItemsNavigationTask >> body [

	workplace addTask: [ | item |

		item := user lookAtList: items of: itemsName.

		self selectItem: item.
		
		^item].
		
	self selectItem: items first.
		
	^items first.
]

{ #category : #testing }
PtyItemsNavigationTask >> canBePrototypeInContextOf: aTask [
	^true
]

{ #category : #'initialize-release' }
PtyItemsNavigationTask >> initialize [ 
	super initialize.
	
	needsFirstSelection := true
]

{ #category : #accessing }
PtyItemsNavigationTask >> needsFirstSelection [

	^ needsFirstSelection
]

{ #category : #accessing }
PtyItemsNavigationTask >> needsFirstSelection: anObject [

	needsFirstSelection := anObject
]

{ #category : #'morphic menu' }
PtyItemsNavigationTask >> populateSettingsMenu: aMenu for: aPrototype [
	super populateSettingsMenu: aMenu for: aPrototype.
	aMenu
		addToggle: 'needs first selection' translated
		target: (aPrototype proxyForSample: self)
		selector: #needsFirstSelection:
		getStateSelector: #needsFirstSelection
		argumentList: {(needsFirstSelection not)}
]

{ #category : #execution }
PtyItemsNavigationTask >> selectItem: anObject [

	listTask ifNil: [listTask := workplace findCurrentTaskLike: PtyShowListTask].

	listTask isNil | items isEmpty ifTrue: [^user lookAtViewArea].
	
	(needsFirstSelection not and: [workplace isCurrentRequestIncludesTask: self])
		ifTrue: [^user lookAtViewArea].
		
	workplace addUIAction: [
		selectedItem ifNotNil: [listTask deselectItem: selectedItem].
		selectedItem := anObject.
		listTask selectItem: selectedItem		
	]
]

{ #category : #testing }
PtyItemsNavigationTask >> shouldRestoreParentArea [ 
	^false
]

{ #category : #testing }
PtyItemsNavigationTask >> shouldSeparateForkTasks [
	^true
]
