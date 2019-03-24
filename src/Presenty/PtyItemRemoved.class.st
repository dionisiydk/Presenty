Class {
	#name : #PtyItemRemoved,
	#superclass : #Announcement,
	#instVars : [
		'itemIndex',
		'item'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyItemRemoved class >> item: anObject [

	^self new 
		item: anObject
]

{ #category : #'instance creation' }
PtyItemRemoved class >> item: anObject index: aNumber [

	^self new 
		item: anObject;
		itemIndex: aNumber 
]

{ #category : #accessing }
PtyItemRemoved >> item [
	^ item
]

{ #category : #accessing }
PtyItemRemoved >> item: anObject [
	item := anObject
]

{ #category : #accessing }
PtyItemRemoved >> itemIndex [
	^ itemIndex
]

{ #category : #accessing }
PtyItemRemoved >> itemIndex: anObject [
	itemIndex := anObject
]
