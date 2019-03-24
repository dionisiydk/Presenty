Class {
	#name : #PtyTaskPrototypeFactory,
	#superclass : #PtyClassBasedPrototypeFactory,
	#category : #'Presenty-Core'
}

{ #category : #factory }
PtyTaskPrototypeFactory >> preferredEditFieldsTask [ 
	self subclassResponsibility 
]

{ #category : #factory }
PtyTaskPrototypeFactory >> preferredEditSingleOptionTask [ 
	^self preferredEditTextTask 
]

{ #category : #factory }
PtyTaskPrototypeFactory >> preferredEditTextTask [
	^PtyEditTextFieldTask new
]

{ #category : #factory }
PtyTaskPrototypeFactory >> preferredFieldEditorTask [

	^PtyEditRequisiteTask new
]

{ #category : #factory }
PtyTaskPrototypeFactory >> preferredItemsSelectionTask [
	^PtySimpleItemsSelectionTask new 
]

{ #category : #factory }
PtyTaskPrototypeFactory >> preferredListTask [
	self subclassResponsibility 
]
