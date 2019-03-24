Class {
	#name : #PtyItemAdded,
	#superclass : #Announcement,
	#instVars : [
		'item'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyItemAdded class >> item: anObject [

	^self new item: anObject 
]

{ #category : #accessing }
PtyItemAdded >> item [
	^ item
]

{ #category : #accessing }
PtyItemAdded >> item: anObject [
	item := anObject
]
