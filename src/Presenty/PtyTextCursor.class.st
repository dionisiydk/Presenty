Class {
	#name : #PtyTextCursor,
	#superclass : #Announcer,
	#instVars : [
		'currentPiece',
		'location'
	],
	#category : #'Presenty-TextEditor'
}

{ #category : #'instance creation' }
PtyTextCursor class >> on: aPtyStringPresenter [ 
	^self new 
		currentPiece: aPtyStringPresenter 
]

{ #category : #accessing }
PtyTextCursor >> computeViewPosition [ 

	^currentPiece computeViewPositionForCharAt: location 
]

{ #category : #accessing }
PtyTextCursor >> currentPiece [
	^ currentPiece
]

{ #category : #accessing }
PtyTextCursor >> currentPiece: anObject [
	currentPiece := anObject
]

{ #category : #controlling }
PtyTextCursor >> deleteNextChar [ 

	currentPiece deleteNextCharAt: location
]

{ #category : #controlling }
PtyTextCursor >> deletePreviousChar [ 

	currentPiece deleteNextCharAt: location - 1.
	self location: location - 1
]

{ #category : #'initialize-release' }
PtyTextCursor >> initialize [ 
	super initialize.
	
	location := 0
]

{ #category : #accessing }
PtyTextCursor >> location [
	^ location
]

{ #category : #accessing }
PtyTextCursor >> location: anInteger [
	(anInteger between: 0 and: currentPiece model size)
		ifFalse: [^self].
		
	location := anInteger.
	
	self announce: PtyValueChanged 
	
	
]

{ #category : #controlling }
PtyTextCursor >> moveToPosition: aPoint [ 

	| i offset charSize |
	i := 1.
	offset := 0.
	[i <= currentPiece model size and: [
	charSize := currentPiece view fontToUse widthOf: (currentPiece model at: i).
	offset + (charSize // 2) < (aPoint x - currentPiece view position x) ]] whileTrue: [
		i := i+1.
		offset := offset + charSize].

	self location: i - 1
]

{ #category : #accessing }
PtyTextCursor >> nextLeftWordPosition [  

	| char |

	location - 1 to: 1 by: -1 do: [:i | 
		char := currentPiece model at: i.
		char isSeparator | char isUppercase ifTrue: [^i]
	].

	^0
]

{ #category : #accessing }
PtyTextCursor >> nextRightWordPosition [  

	| char |
	
	location + 1 to: currentPiece model size do: [:i | 
		char := currentPiece model at: i.
		char isSeparator | char isUppercase ifTrue: [^i]
	].

	^currentPiece model size
]

{ #category : #controlling }
PtyTextCursor >> pasteText: aString [

	currentPiece pasteText: aString at: location.
	self location: location + aString size
]

{ #category : #controlling }
PtyTextCursor >> shiftBy: delta [

	self location: location + delta
]
