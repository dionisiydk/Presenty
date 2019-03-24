"
I am a factory of user objects like tasks and presenters.

Instance Variables:
	userFeeling	<PtyUserFeeling>
"
Class {
	#name : #PtyClassBasedPrototypeFactory,
	#superclass : #PtyPrototypeFactory,
	#category : #PrototypesManager
}

{ #category : #testing }
PtyClassBasedPrototypeFactory >> canPrototype: aPrototype supplyInstancesFor: anObject [

	| possibleInstance |
	possibleInstance := aPrototype newInstance.
	possibleInstance readSampleProperitiesFrom: anObject.
	^possibleInstance canBePrototypeInContextOf: anObject 
]

{ #category : #'prototypes creation' }
PtyClassBasedPrototypeFactory >> createPrototypeFor: requestedObject [

	| class sample |

	class := requestedObject ptyPrototypeClass.
	
	sample := class definesPreferredInstance 
		ifTrue: [class createPreferredInstanceBy: self]
		ifFalse: [class appropriateInstanceInContextOf: requestedObject].
		
	^PtyPrototype sample: sample class: class
		
	
]
