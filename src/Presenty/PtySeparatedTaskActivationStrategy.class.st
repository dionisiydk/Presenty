Class {
	#name : #PtySeparatedTaskActivationStrategy,
	#superclass : #PtyTaskActivationStrategy,
	#instVars : [
		'areaActivator'
	],
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtySeparatedTaskActivationStrategy >> areaActivator [
	^ areaActivator
]

{ #category : #accessing }
PtySeparatedTaskActivationStrategy >> areaActivator: anObject [
	areaActivator := anObject.
	areaActivator taskActivation: self
]

{ #category : #accessing }
PtySeparatedTaskActivationStrategy >> createCopy [ 

	^super createCopy
		 areaActivator: areaActivator copy
]

{ #category : #'initialize-release' }
PtySeparatedTaskActivationStrategy >> initialize [ 
	super initialize.
	
	areaActivator := PtyNewAreaActivator for: self
]

{ #category : #accessing }
PtySeparatedTaskActivationStrategy >> parent: anActivationStrategy [
	anActivationStrategy ifNil: [^self].
	super parent: anActivationStrategy.
	
	areaActivator parentActivator:  anActivationStrategy areaActivator
]

{ #category : #'morphic-menu' }
PtySeparatedTaskActivationStrategy >> populateSettingsMenu: aMenu for: aPrototype [
	| activators subMenu |
	super populateSettingsMenu: aMenu for: aPrototype.
	activators := PtyViewAreaActivator allSubclasses copyWithout: areaActivator class.
	activators ifEmpty: [ ^ self ].
	subMenu := MenuMorph new defaultTarget: self.
	activators
		do: [ :each | 
			subMenu
				add: each name
				target: (aPrototype proxyForSample: self)
				selector: #useAreaActivatorOf:
				argumentList: {each} ].
	aMenu add: 'replace ' , areaActivator class name , ' with:' subMenu: subMenu
]

{ #category : #execution }
PtySeparatedTaskActivationStrategy >> setUpNewViewArea [

	| area |
	area := PtyViewAreaPresenter new.
	area context: guide context.
	area guide: guide.
	
	guide viewArea: area

]

{ #category : #accessing }
PtySeparatedTaskActivationStrategy >> useAreaActivatorOf: aViewAreaActivatorClass [

	self areaActivator: aViewAreaActivatorClass new.
	
]
