Class {
	#name : #PtyViewBuildContext,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'prototype'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyViewBuildContext class >> presenter: aPresenter prototype: aPrototype [ 
	^self new 
		presenter: aPresenter;
		prototype: aPrototype 
]

{ #category : #accessing }
PtyViewBuildContext >> basePrototypeContexts [
	^presenter basePrototypeContexts 
]

{ #category : #accessing }
PtyViewBuildContext >> guide [
	^ presenter guide
]

{ #category : #testing }
PtyViewBuildContext >> isCurrentLanguage: aLanguage [

	^self guide translator currentLanguage == aLanguage 
]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populateMenu: aMenu withParentTasksOf: aTaskContext [

	| parents taskMenu |

	parents := aTaskContext taskCallChain.
	parents := parents select: [:each | each hasPrototype].
	parents ifEmpty: [^self].
	
	parents reverseDo: [:each |
		taskMenu := MenuMorph new defaultTarget: self.
		self populateTaskSettingsMenu: taskMenu for: each.
		aMenu add: each printString subMenu: taskMenu]
	
	
		
]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populatePresentyMenu: aMenu for: aView [

	aMenu add: 'save view and subviews changes' translated action: #applyPrototypeChanges.
	aMenu add: 'save view own changes' translated action: #applyOwnPrototypeChanges.
	aMenu addLine.
	self populateViewSettingsMenu: aMenu.
	aMenu addLine.
	self populateUserActionsMenu: aMenu.
	self populateTaskSettingsMenu: aMenu.
	self populateTranslatorMenu: aMenu.
	aMenu addLine.
	PtyClipboard default populateMenu: aMenu for: aView.
	aMenu addLine.
	presenter guide populateMenuItems: aMenu.
]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populatePrototypeConsumerMenu: aMenu [

	aMenu add: 'explore build context' translated 
		target: self selector: #explore argumentList: #().
	
	aMenu add: 'browse presenter' translated 
		target: presenter selector: #browse argumentList: #().
]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populateTaskSettingsMenu: aMenu [

	| parents subMenu taskMenu requestsMenu |

	requestsMenu := MenuMorph new defaultTarget: self.
	
	self guide activeTasks do: [:eachTask | 
		taskMenu := MenuMorph new defaultTarget: self.
		self populateTaskSettingsMenu: taskMenu for: eachTask task.
		requestsMenu add: eachTask task printString subMenu: taskMenu.		
	].
	
	aMenu add: 'current requests' translated subMenu: requestsMenu.
			
	presenter context ifNotNil: [
		subMenu := MenuMorph new defaultTarget: self.
		self populateMenu: subMenu withParentTasksOf: presenter context.
		aMenu add: 'presenter tasks' translated subMenu: subMenu].
	

]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populateTaskSettingsMenu: aMenu for: aTask [
	
	aTask prototype populateMenu: aMenu by: self guide uiSettings taskPrototypes for: aTask
]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populateTranslatorMenu: aMenu [

	| subMenu |
	
	subMenu := MenuMorph new defaultTarget: self.
	
	self guide translator languages do: [:each |
		subMenu 
			addToggle: each name
			target:  self
			selector: #setLanguage:  
			getStateSelector:  #isCurrentLanguage: 
			argumentList: {each}].
	subMenu add: 'set new language' translated action: #setNewLanguage.
	aMenu addLine.
	aMenu add: 'language' translated subMenu: subMenu.
	
		
]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populateUserActionsMenu: aMenu [

	| subMenu taskMenu |
	presenter userActions ifEmpty: [^self].
	
	subMenu := MenuMorph new defaultTarget: self.
		
	presenter userActions do: [:each |
		taskMenu := MenuMorph new defaultTarget: self.
		each populateSettingsMenu: taskMenu.
		subMenu add: each prototypeContextName subMenu: taskMenu].
		
	aMenu add: 'user actions' translated subMenu: subMenu.
	
	
	
		
]

{ #category : #'morphic menu' }
PtyViewBuildContext >> populateViewSettingsMenu: aMenu [

	prototype populateMenu: aMenu by: self viewPrototypes for: self
	
		
]

{ #category : #accessing }
PtyViewBuildContext >> presenter [
	^ presenter
]

{ #category : #accessing }
PtyViewBuildContext >> presenter: anObject [
	presenter := anObject
]

{ #category : #printing }
PtyViewBuildContext >> printPresenterViewName [
	| presenterName |
	presenterName := presenter hasStyle 
		ifTrue: [presenter prototypeStyleContextName]
		ifFalse: [presenter prototypeContextName].
	^'prototype of ', presenterName
]

{ #category : #accessing }
PtyViewBuildContext >> prototype [
	^ prototype
]

{ #category : #accessing }
PtyViewBuildContext >> prototype: anObject [
	prototype := anObject
]

{ #category : #accessing }
PtyViewBuildContext >> prototypeContextName [
	^self printPresenterViewName 
]

{ #category : #accessing }
PtyViewBuildContext >> resourcesManager [ 
	^ presenter guide resourcesManager
]

{ #category : #controlling }
PtyViewBuildContext >> saveAsPrototype: aView [

	prototype saveNewSample: aView
]

{ #category : #controlling }
PtyViewBuildContext >> setLanguage: aLanguage [

	self guide useLanguage: aLanguage
]

{ #category : #controlling }
PtyViewBuildContext >> setNewLanguage [

	| newLangName lang |
	newLangName := UIManager default request: 'Input language name'.
	newLangName ifEmpty: [^self].
		
	lang := self guide translator addLanguage: newLangName. 

	self guide useLanguage: lang 
]

{ #category : #accessing }
PtyViewBuildContext >> viewPrototypes [
	^ self guide uiSettings viewPrototypes
]
