Class {
	#name : #PtyStringPresenter,
	#superclass : #PtyPresenter,
	#category : #'Presenty-BasicPresenters'
}

{ #category : #accessing }
PtyStringPresenter class >> defaultView [

	^PtyStringMorph new
]

{ #category : #presentation }
PtyStringPresenter >> computeViewPositionForCharAt: index [

	^view computePositionForCharAt: index
]

{ #category : #presentation }
PtyStringPresenter >> deleteNextCharAt: index [

	| read newModel |
	index >= model  size ifTrue: [^self].
	index >= 0 ifFalse: [^self].
	
	read := model readStream.
	
	newModel := WriteStream on: (String new: model size - 1).
	
	newModel 
		nextPutAll: (read next: index);
		nextPutAll: (read next; upToEnd).
		
	model := newModel contents.
	self showViewItems 
	

	
]

{ #category : #presentation }
PtyStringPresenter >> pasteText: aString at: index [

	| read newModel |
	read := model readStream.
	
	newModel := WriteStream on: (String new: model size + aString size).
	
	newModel 
		nextPutAll: (read next: index);
		nextPutAll: aString;
		nextPutAll: read upToEnd.
		
	model := newModel contents.
	self showViewItems 
	

	
]

{ #category : #presentation }
PtyStringPresenter >> showViewItems [
	view contents: model.
]
