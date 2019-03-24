Class {
	#name : #PtyTask,
	#superclass : #Object,
	#instVars : [
		'guide',
		'user',
		'name',
		'announcer',
		'prototype',
		'context',
		'executionStrategy'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTask class >> named: aString [
	^self new name: aString 
]

{ #category : #controlling }
PtyTask >> activationRequest [

	^PtyRunTaskRequest for: self
]

{ #category : #accessing }
PtyTask >> activationStrategy [
	^ executionStrategy
]

{ #category : #accessing }
PtyTask >> activationStrategy: anObject [
	executionStrategy := anObject
]

{ #category : #testing }
PtyTask >> allowChangeParentViewAreaState [
	^true
]

{ #category : #testing }
PtyTask >> allowSeparateItems [
	^true
]

{ #category : #accessing }
PtyTask >> announce: anAnnouncement [

	announcer announce: anAnnouncement.
	context ifNotNil: [self parent announce: anAnnouncement ]
]

{ #category : #accessing }
PtyTask >> announcer [
	^ announcer
]

{ #category : #accessing }
PtyTask >> announcer: anObject [
	announcer := anObject
]

{ #category : #converting }
PtyTask >> asNewApplication [
	^PtyRunApplicationTask on: self
]

{ #category : #converting }
PtyTask >> asTask [
	^self
]

{ #category : #converting }
PtyTask >> asUserAction [
	^PtyActivateTask task: self
]

{ #category : #accessing }
PtyTask >> basePrototypeContexts [
	^{PtyTaskPrototypeContext of: self}
]

{ #category : #'initialize-release' }
PtyTask >> beDeferred [

	^executionStrategy := PtyDeferredTaskExecution new
]

{ #category : #'initialize-release' }
PtyTask >> beImmediate [

	^executionStrategy := PtyImmediateTaskExecution new
]

{ #category : #'initialize-release' }
PtyTask >> beOneShot [

	^executionStrategy := PtyOneShotTaskExecution new
]

{ #category : #execution }
PtyTask >> body [
	self subclassResponsibility 
]

{ #category : #testing }
PtyTask >> canBePrototypeInContextOf: aTask [
	
	^(aTask isCreatedByCurrentRequestFrom: self) not
]

{ #category : #accessing }
PtyTask >> context [
	^context
]

{ #category : #accessing }
PtyTask >> context: aTaskContext [
	context := aTaskContext 
]

{ #category : #accessing }
PtyTask >> copyAsNewInstance [
	^self veryDeepCopy 
]

{ #category : #copying }
PtyTask >> copyAsPrototype [

	^self veryDeepCopy 
]

{ #category : #controlling }
PtyTask >> createContextFor: anActivationStrategy [

	| newContext |
	newContext := PtyTaskContext of: self.
	newContext activation: anActivationStrategy.
	^newContext
]

{ #category : #accessing }
PtyTask >> defaultActivationStrategy [

	^PtyInheritedActivationStrategy new 
		shouldRestoreParentArea: self shouldRestoreParentArea;
		allowSeparateItems: self allowSeparateItems;
		yourself 
]

{ #category : #'initialize-release' }
PtyTask >> defaultExecutionStrategy [
	^PtyOneShotTaskExecution new
]

{ #category : #accessing }
PtyTask >> defaultPrototypeContextName [
	^self class name
]

{ #category : #accessing }
PtyTask >> executionStrategy [
	^ executionStrategy
]

{ #category : #accessing }
PtyTask >> executionStrategy: aTaskExecutionStrategy [
	executionStrategy := aTaskExecutionStrategy
]

{ #category : #accessing }
PtyTask >> findCommonParentWith: aTask [

	| commonParent |
	context ifNil: [^nil].
	aTask context ifNil: [^nil].
	
	commonParent := aTask context taskCallChain detect: [:each | each == self parent] ifNone: [nil].
	commonParent ifNotNil: [^commonParent].
	
	^self parent findCommonParentWith: aTask 
		
]

{ #category : #accessing }
PtyTask >> guide [
	^ guide
]

{ #category : #accessing }
PtyTask >> guide: anObject [
	guide := anObject
]

{ #category : #testing }
PtyTask >> hasParentSuchThat: aBlock [

	context ifNil: [^false].
	
	(aBlock value: self parent) ifTrue: [^true].
	
	^self parent hasParentSuchThat: aBlock 
]

{ #category : #testing }
PtyTask >> hasPrototype [

	^prototype notNil 
]

{ #category : #'initialize-release' }
PtyTask >> initialize [ 
	super initialize.
	
	announcer := Announcer new.
	executionStrategy := self defaultExecutionStrategy
]

{ #category : #testing }
PtyTask >> isChildrenShouldRestoreParentArea [

	executionStrategy shouldRestoreParentArea ifFalse: [^false].
	
	context ifNil: [^true].
	
	context shouldRestoreParentArea ifTrue: [^true].
	
	^self parent isChildrenShouldRestoreParentArea
]

{ #category : #testing }
PtyTask >> isCreatedByCurrentRequest [

	^guide isCurrentRequestIncludesTask: self
]

{ #category : #testing }
PtyTask >> isCreatedByCurrentRequestFrom: aTask [ 

	| parentTask |
	context ifNil: [^false].
	
	parentTask := context task.
	
	parentTask isCreatedByCurrentRequest ifFalse: [^false].
	
	(parentTask isSimilarTo: aTask) ifTrue: [^true].
	
	^parentTask isCreatedByCurrentRequestFrom: aTask
	
]

{ #category : #testing }
PtyTask >> isKindOfTask: aTask [ 
	(self isKindOf: aTask class) ifFalse: [^false].
	
	^name = aTask name
]

{ #category : #testing }
PtyTask >> isSimilarTo: aTask [ 
	self class == aTask class ifFalse: [^false].
	
	^name = aTask name
]

{ #category : #accessing }
PtyTask >> name [
	^ name
]

{ #category : #accessing }
PtyTask >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PtyTask >> parent [
	context ifNil: [^nil].
	
	^ context task
]

{ #category : #accessing }
PtyTask >> parentLike: taskClass [

	(self parent isKindOf: taskClass) ifTrue: [^self parent].
	
	^self parent parentLike: taskClass 
]

{ #category : #controlling }
PtyTask >> performExtraRequestBy: aGuide [

	aGuide requestUserFor: (PtyAddExtraTask on: self)
]

{ #category : #'morphic menu' }
PtyTask >> populateSettingsMenu: aMenu for: aPrototype [ 

	| activations subMenu |
	activations := PtyTaskActivationStrategy allSubclasses copyWithout: executionStrategy class.
	activations ifEmpty: [ ^ self ].
	
	subMenu := MenuMorph new defaultTarget: self.
	activations
		do: [ :each | 
			subMenu
				add: each name
				target: (aPrototype proxyForSample: self)
				selector: #useTaskActivationOf:
				argumentList: {each} ].
	aMenu add: 'replace ' , executionStrategy class name , ' with:' subMenu: subMenu.
	
	executionStrategy populateSettingsMenu: aMenu for: aPrototype
]

{ #category : #controlling }
PtyTask >> prepareActivationBy: aGuide [

	| newActivation |
	guide := aGuide.
	user := aGuide user.
	context := aGuide context.
	
	newActivation := executionStrategy createCopy.
	newActivation 
		guide: aGuide;
		parent: context activation.
	newActivation prepareForEscapeTo: self fromContext: context.
	
	^newActivation.
]

{ #category : #printing }
PtyTask >> printDetailsOn: aStream [

	name ifNil: [^self].
	
	aStream 
		nextPut: $(;
		nextPutAll: name;
		nextPut: $)
	
]

{ #category : #printing }
PtyTask >> printOn: aStream [

	super printOn: aStream.
	
	self printDetailsOn: aStream
]

{ #category : #accessing }
PtyTask >> prototype [
	^ prototype
]

{ #category : #accessing }
PtyTask >> prototype: anObject [
	prototype := anObject
]

{ #category : #accessing }
PtyTask >> prototypeContextName [
	^name ifNil: [self defaultPrototypeContextName]
]

{ #category : #converting }
PtyTask >> readFromSample: aTask [
	
	self class allInstVarNames do: [:each | 
		(self instVarNamed: each) ifNil: [ | i |
			i := aTask class instVarIndexFor: each ifAbsent: [nil].
			i ifNotNil: [
				self instVarNamed: each put: (aTask instVarAt: i)]
		]
			
	]
]

{ #category : #accessing }
PtyTask >> readSampleProperitiesFrom: someRequestedTask [
	super readSampleProperitiesFrom: someRequestedTask.
	
	name := someRequestedTask name
]

{ #category : #testing }
PtyTask >> shouldRestoreParentArea [ 
	^true
]

{ #category : #testing }
PtyTask >> shouldSeparateForkTasks [
	^false
]

{ #category : #accessing }
PtyTask >> useTaskActivationOf: aTaskActivationStrategyClass [

	self activationStrategy: aTaskActivationStrategyClass new.
	
]

{ #category : #accessing }
PtyTask >> user [
	^ user
]

{ #category : #accessing }
PtyTask >> user: anObject [
	user := anObject
]