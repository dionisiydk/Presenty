Class {
	#name : #PtyInputListFieldTask,
	#superclass : #PtyTask,
	#instVars : [
		'field'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #'instance creation' }
PtyInputListFieldTask class >> field: aFieldModel [

	^self new 
		field: aFieldModel 
]

{ #category : #execution }
PtyInputListFieldTask >> body [ 

	| item |

	item := user select: 'ListFieldItem' from: field type items.

	field value: item value.

	context resumeWith: true
]

{ #category : #accessing }
PtyInputListFieldTask >> field [
	^ field
]

{ #category : #accessing }
PtyInputListFieldTask >> field: anObject [
	field := anObject
]
