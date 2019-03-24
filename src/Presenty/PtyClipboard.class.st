Class {
	#name : #PtyClipboard,
	#superclass : #Object,
	#instVars : [
		'fillStyle',
		'view'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Presenty-UI'
}

{ #category : #accessing }
PtyClipboard class >> default [
	^ default ifNil: [default := PtyClipboard new]
]

{ #category : #accessing }
PtyClipboard class >> default: anObject [
	default := anObject
]

{ #category : #operations }
PtyClipboard >> copyFillStyleFrom: aView [

	fillStyle := aView fillStyle veryDeepCopy 
]

{ #category : #operations }
PtyClipboard >> copyPrototypeFrom: aView [

	view := aView buildContext prototype view veryDeepCopy
]

{ #category : #operations }
PtyClipboard >> copyView: aView [

	view := aView veryDeepCopy
]

{ #category : #accessing }
PtyClipboard >> fillStyle [
	^ fillStyle
]

{ #category : #accessing }
PtyClipboard >> fillStyle: anObject [
	fillStyle := anObject
]

{ #category : #operations }
PtyClipboard >> pasteFillStyleTo: aView [

	| fill |
	fill := fillStyle veryDeepCopy.
	fill origin: aView position.
	aView fillStyle: fill
]

{ #category : #operations }
PtyClipboard >> pastePrototypeTo: aView [

	aView buildContext prototype sample: view
]

{ #category : #operations }
PtyClipboard >> pasteViewTo: aView [

	aView add: view
]

{ #category : #menu }
PtyClipboard >> populateMenu: aMenu for: aView [

	aMenu add:  'copy view' target: self selector: #copyView:  argumentList: {aView}.
	aMenu add:  'copy fill style' target: self selector: #copyFillStyleFrom: argumentList: {aView}.
	aMenu add:  'copy prototype' target: self selector: #copyPrototypeFrom:  argumentList: {aView}.
	view ifNotNil: [
		aMenu add:  'paste prototype' target: self selector: #pastePrototypeTo: argumentList: {aView}.
		aMenu add:  'paste view' target: self selector: #pasteViewTo: argumentList: {aView}].
	fillStyle ifNotNil: [
		aMenu add:  'paste fill style' target: self selector: #pasteFillStyleTo: argumentList: {aView}.
		]
]

{ #category : #accessing }
PtyClipboard >> prototype [
	^ prototype
]

{ #category : #accessing }
PtyClipboard >> prototype: anObject [
	prototype := anObject
]

{ #category : #accessing }
PtyClipboard >> view [
	^ view
]

{ #category : #accessing }
PtyClipboard >> view: anObject [
	view := anObject
]
