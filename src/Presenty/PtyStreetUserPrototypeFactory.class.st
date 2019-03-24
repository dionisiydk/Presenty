Class {
	#name : #PtyStreetUserPrototypeFactory,
	#superclass : #PtyTaskPrototypeFactory,
	#category : #'Presenty-StreetUser'
}

{ #category : #factory }
PtyStreetUserPrototypeFactory >> preferredEditSingleOptionTask [
	^self preferredEditTextTask 
]

{ #category : #factory }
PtyStreetUserPrototypeFactory >> preferredEditTextTask [
	^PtyEditRequisiteWithToolTask new
]

{ #category : #factory }
PtyStreetUserPrototypeFactory >> preferredFieldEditorTask [

	^PtyEditRequisiteByToolTask new
]

{ #category : #factory }
PtyStreetUserPrototypeFactory >> preferredListTask [
	^PtyShowListLikeBookTask new
]
