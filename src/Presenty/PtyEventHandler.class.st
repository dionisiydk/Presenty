Class {
	#name : #PtyEventHandler,
	#superclass : #Object,
	#instVars : [
		'mouseWheelRecipient',
		'mouseWheelSelector'
	],
	#category : #'Presenty-UI'
}

{ #category : #'as yet unclassified' }
PtyEventHandler >> handlesMouseOver: evt [
	"Answer whether we can handle the event."
	
	mouseWheelRecipient ifNotNil: [^ true].
	^super handlesMouseOver: evt
]

{ #category : #'as yet unclassified' }
PtyEventHandler >> handlesMouseWheel: evt [
	"Answer whether we can handle the event."
	
	mouseWheelRecipient ifNotNil: [^ true].
	^false
]

{ #category : #'as yet unclassified' }
PtyEventHandler >> methodRefList [
	"Return a MethodReference for each message I can send."
	
	|list adder|
	list := super methodRefList.
	adder := [:recip :sel | recip
				ifNotNil: [list
						add: (MethodReference new
								setStandardClass: (recip class whichClassIncludesSelector: sel)
								methodSymbol: sel)]].
	adder value: mouseWheelRecipient value: mouseWheelSelector.
	^list
]

{ #category : #'as yet unclassified' }
PtyEventHandler >> mouseWheel: event fromMorph: sourceMorph [
	"Relay the event."
	
	^ self send: mouseWheelSelector to: mouseWheelRecipient withEvent: event fromMorph: sourceMorph
]

{ #category : #'as yet unclassified' }
PtyEventHandler >> on: eventName send: selector to: recipient [
	"Register the selector and recipient for the given event name."
	
	eventName == #mouseWheel ifTrue:
		[mouseWheelRecipient := recipient.  mouseWheelSelector := selector. ^ self].
	^super on: eventName send: selector to: recipient
]
