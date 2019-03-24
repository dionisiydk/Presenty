Class {
	#name : #PtyActiveDataModel,
	#superclass : #Announcer,
	#instVars : [
		'data'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #'instance creation' }
PtyActiveDataModel class >> on: aValueDataObject [
	^self new 
		data: aValueDataObject 
]

{ #category : #accessing }
PtyActiveDataModel >> data [
	^ data
]

{ #category : #accessing }
PtyActiveDataModel >> data: anObject [
	data := anObject
]

{ #category : #accessing }
PtyActiveDataModel >> value [
	^data value 
]

{ #category : #accessing }
PtyActiveDataModel >> value: anObject [

	data value: anObject.
	self announce: PtyValueChanged 
]
