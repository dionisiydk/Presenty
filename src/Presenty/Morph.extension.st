Extension { #name : #Morph }

{ #category : #'*Presenty-UI' }
Morph >> add: aMorph [

	self addMorphBack: aMorph.
]

{ #category : #'*Presenty-UI' }
Morph >> addContainerMenuItems: aCustomMenu [

	aCustomMenu add: 'add container' translated action: #addContainer.
	aCustomMenu add: 'add text label' translated action: #addTextLabel.
	aCustomMenu add: 'add image label' translated action: #addImageLabel.	
	aCustomMenu add: 'use background from file' translated action: #useBackgroundFile.
	self hasBackgroundFile 
		ifTrue: [	aCustomMenu add: 'reset background file' translated action: #resetBackgroundFile].
	aCustomMenu add: 'add icon' translated action: #addIcon.
	self hasBuildContext ifFalse: [
		aCustomMenu addLine.
		aCustomMenu add: 'migrate all neighbors' translated action: #migrateNeighbors].	
	self addPresentyMenuTo: aCustomMenu
]

{ #category : #'*Presenty-UI' }
Morph >> addPresentyMenuTo: aMenu [

	self hasBuildContext ifFalse: [^self].
	aMenu addLine.
	self buildContext populatePresentyMenu: aMenu for: self
]

{ #category : #'*Presenty-UI' }
Morph >> applyOwnPrototypeChanges [

	self hasBuildContext ifFalse: [^self].
	
	self buildContext saveAsPrototype: self.

]

{ #category : #'*Presenty-UI' }
Morph >> applyPrototypeChanges [

	self applyOwnPrototypeChanges.
	self submorphsDo: [:each | each applyPrototypeChanges ].
]

{ #category : #'*Presenty-UI' }
Morph >> buildContext [
	^self valueOfProperty: #buildContext 
]

{ #category : #'*Presenty-UI' }
Morph >> buildContext: aBuildContext [
	self setProperty: #buildContext toValue: aBuildContext.
	aBuildContext ifNil: [^self].
	self name: aBuildContext printPresenterViewName
]

{ #category : #'*Presenty-UI' }
Morph >> cleanupForPrototype [
	self cleanupYourselfForPrototype.
	
	self submorphsDo: [:each | each cleanupForPrototype]
]

{ #category : #'*Presenty-UI' }
Morph >> cleanupYourselfForPrototype [
	self buildContext: nil.
	self extension ifNotNil:  [self eventHandler: nil].
	self removeProperty: #kmDispatcher
]

{ #category : #'*Presenty-UI' }
Morph >> collectCopyPreventedResourcesTo: aCollection [ 

	self collectOwnCopyPreventedResourcesTo: aCollection.
	
	self submorphsDo: [:each | each collectCopyPreventedResourcesTo: aCollection]
]

{ #category : #'*Presenty-UI' }
Morph >> collectOwnCopyPreventedResourcesTo: aCollection [

	self hasBuildContext ifTrue: [aCollection add: self buildContext].
	self eventHandler ifNotNil: [:h | aCollection add: h].
	(self hasProperty: #kmDispatcher) ifTrue: [aCollection add: self kmDispatcher]
]

{ #category : #'*Presenty-UI' }
Morph >> collectViewsWithPrototypeTo: aCollection [ 

	self submorphsDo: [:each | 
		each hasBuildContext ifTrue: [
			aCollection add: each.
			each collectViewsWithPrototypeTo: aCollection ]]
]

{ #category : #'*Presenty-UI' }
Morph >> copyAsNewInstance [

	^self veryDeepCopy 
]

{ #category : #'*Presenty-UI' }
Morph >> copyAsPrototype [ 

	| copier resources copy |
	copier := DeepCopier new initialize: 4096 "self initialDeepCopierSize".
	resources := IdentitySet new: 128.
	self collectCopyPreventedResourcesTo: resources.
	resources do: [:each | copier references at: each put: each].
	"self collectViewsWithPrototypeTo: resources."

	copy := self veryDeepCopyWith: copier.
	
	resources do: [:each | copier references removeKey: each].
	
	copier references associationsDo: [:assoc | 
		assoc value veryDeepFixupWith: copier].
	copier fixDependents.

	copy delete.
	copy deletePrototypeViews.
	copy cleanupForPrototype.
	^copy
]

{ #category : #'*Presenty-UI' }
Morph >> deletePrototypeViews [

	(self submorphs select: [:each | each hasBuildContext]) do: [:each | each delete].
	
	self submorphsDo: [:each | each deletePrototypeViews]	

]

{ #category : #'*Presenty-UI' }
Morph >> findBuildContext [
	self hasBuildContext ifTrue: [^self buildContext].
	
	^owner findBuildContext
]

{ #category : #'*Presenty-UI' }
Morph >> hasBackgroundFile [

	^self hasProperty: #backgroundFile.

	
]

{ #category : #'*Presenty-UI' }
Morph >> hasBuildContext [

	^self hasProperty: #buildContext.

	
]

{ #category : #'*Presenty-UI' }
Morph >> populateSettingsMenu: aMenuMorph for: aPtyPrototype [ 

]

{ #category : #'*Presenty-UI' }
Morph >> prototypesManager [ 
	self hasBuildContext ifTrue: [^self buildContext prototypesManager].
	
	^owner prototypesManager
]

{ #category : #'*Presenty-UI' }
Morph >> ptyBackgroundFile [
	^self valueOfProperty: #backgroundFile 
]

{ #category : #'*Presenty-UI' }
Morph >> ptyBackgroundFile: filename [

	self setProperty: #backgroundFile toValue: filename.
	
	self setBackgroundFromFileBy: self findBuildContext guide resourcesManager
]

{ #category : #'*Presenty-UI' }
Morph >> ptyFlowBounds [

	self listDirection == #leftToRight ifTrue: [^PtyLeftToRightFlowBounds bounds: bounds].
	self listDirection == #topToBottom ifTrue: [^PtyTopToBottomFlowBounds bounds: bounds].
	self error: 'Not supported flow direction'
]

{ #category : #'*Presenty-UI' }
Morph >> ptyLoadResourcesBy: aGuide [

	self hasBackgroundFile ifTrue: [self setBackgroundFromFileBy: aGuide resourcesManager].
	
	self submorphsDo: [:each | each ptyLoadResourcesBy: aGuide]
]

{ #category : #'*Presenty-UI' }
Morph >> replaceWith: aMorph [
	owner ifNil: [^self].
	owner replaceSubmorph: self by: aMorph 
]

{ #category : #'*Presenty-UI' }
Morph >> resetBackgroundFile [

	^self removeProperty: #backgroundFile

	
]

{ #category : #'*Presenty-UI' }
Morph >> setBackgroundFromFile [
	
	| image fill |
	image := self findBuildContext resourcesManager loadImage: self ptyBackgroundFile.

	fill := AlphaInfiniteForm with: image.
	self fillStyle: fill.
	self extent: image extent.
]

{ #category : #'*Presenty-UI' }
Morph >> setBackgroundFromFileBy: aResourcesManager [
	
	| image fill |
	image := aResourcesManager loadImage: self ptyBackgroundFile.

	fill := AlphaInfiniteForm with: image.
	self fillStyle: fill.
	
	self extent: image extent.
]

{ #category : #'*Presenty-UI' }
Morph >> translateContentBy: aTranslator [
	
	self submorphsDo: [:each | each translateContentBy: aTranslator]
]

{ #category : #'*Presenty-UI' }
Morph >> translateSubViewsBy: aGuide [	
	
	self submorphsDo: [:each | aGuide translateContentOf: each]
]

{ #category : #'*Presenty-UI' }
Morph >> updateLayoutRecursivelly [
	
	self submorphs 	do: [:each | each updateLayoutRecursivelly].
		
	self layoutChanged.
]
