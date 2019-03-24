Class {
	#name : #PtyUserAction,
	#superclass : #Object,
	#instVars : [
		'connector',
		'connectorPrototype',
		'name',
		'presenter',
		'id'
	],
	#category : #'Presenty-Core'
}

{ #category : #convertion }
PtyUserAction >> asUserAction [ 
	^self
]

{ #category : #accessing }
PtyUserAction >> basePrototypeContexts [ 

	^ presenter basePrototypeContexts 
]

{ #category : #testing }
PtyUserAction >> canBeExecutedWith: executionParameterObject [
	"By default any basic user actions can be executed with parameter. They just perform #execute"
	^true
]

{ #category : #'connecting tasks' }
PtyUserAction >> connectToPresenterBy: anUISettings [

	connectorPrototype := anUISettings userActionPrototypes prototypeFor: self.
	connector := connectorPrototype newInstance.
	connector connectAction: self to: presenter
]

{ #category : #accessing }
PtyUserAction >> connector [
	^ connector
]

{ #category : #accessing }
PtyUserAction >> connector: anObject [
	connector := anObject
]

{ #category : #accessing }
PtyUserAction >> connectorPrototype [
	^ connectorPrototype
]

{ #category : #accessing }
PtyUserAction >> connectorPrototype: anObject [
	connectorPrototype := anObject
]

{ #category : #accessing }
PtyUserAction >> defaultPrototypeContextName [ 
	^self class name
]

{ #category : #'enabling/disabling' }
PtyUserAction >> disable [
	connector activators do: [:activator | activator disable ]
]

{ #category : #'enabling/disabling' }
PtyUserAction >> enable [
	connector activators do: [:activator | activator enable ]
]

{ #category : #execution }
PtyUserAction >> execute [ 
	self subclassResponsibility
]

{ #category : #execution }
PtyUserAction >> executeWith: executionParameterObject [
	
	self subclassResponsibility 
]

{ #category : #accessing }
PtyUserAction >> id [
	^ id
]

{ #category : #initialize }
PtyUserAction >> initialize [
	super initialize.
	id := Object new
]

{ #category : #accessing }
PtyUserAction >> name [
	^ name
]

{ #category : #accessing }
PtyUserAction >> name: anObject [
	name := anObject
]

{ #category : #'morphic menu' }
PtyUserAction >> populateSettingsMenu: aMenu [

	connectorPrototype 
		populateMenu: aMenu by: presenter guide uiSettings userActionPrototypes for: self.
	
	
]

{ #category : #accessing }
PtyUserAction >> presenter [
	^ presenter
]

{ #category : #accessing }
PtyUserAction >> presenter: anObject [
	presenter := anObject
]

{ #category : #accessing }
PtyUserAction >> prototype: aPtyPrototype [ 
	connectorPrototype := aPtyPrototype 
]

{ #category : #accessing }
PtyUserAction >> prototypeContextName [ 
	^name ifNil: [self defaultPrototypeContextName]
]
