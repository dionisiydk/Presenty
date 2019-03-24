Class {
	#name : #PtyObjectAspectTests,
	#superclass : #TestCase,
	#instVars : [
		'aspect',
		'subject'
	],
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyObjectAspectTests >> setUp [
	super setUp.
	
	subject := Mock new.
	aspect := PtyObjectAspect of: subject path: #(#aspect)
]

{ #category : #tests }
PtyObjectAspectTests >> testCreationFromObject [

	| actual |
	subject := Object new.

	actual := subject ptyAspect: #path.
	
	actual subject should be: subject.
	actual path should be: #path
]

{ #category : #tests }
PtyObjectAspectTests >> testGettingValueWhenItIsNil [

	[
		aspect path: #(aspect).
		[aspect value should be: nil]
			should strictly satisfy: 
		[(subject respondsTo: #aspect) willReturn: true.
		(subject perform: #aspect) willReturn: nil]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testGettingValueWhenLongPath [

	[:aspect1Value |
		aspect path: #(aspect1 aspect2).
		[aspect value should be: #aspect2Value ]
			should strictly satisfy: 
		[(subject respondsTo: #aspect1) willReturn: true.
		(subject perform: #aspect1) willReturn: aspect1Value.
		(aspect1Value respondsTo: #aspect2) willReturn: true.
		(aspect1Value perform: #aspect2) willReturn: #aspect2Value]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testGettingValueWhenLongPathAndSomeAspectDontExist [

	[:aspect1Value |
		aspect path: #(aspect1 aspect2).
		[aspect value should be: nil]
			should strictly satisfy: 
		[(subject respondsTo: #aspect1) willReturn: true.
		(subject perform: #aspect1) willReturn: aspect1Value.
		(aspect1Value respondsTo: #aspect2) willReturn: false]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testGettingValueWhenLongPathAndSomeIsNil [

	[
		aspect path: #(aspect1 aspect2).
		[aspect value should be: nil]
			should strictly satisfy: 
		[(subject respondsTo: #aspect1) willReturn: true.
		(subject perform: #aspect1) willReturn: nil]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testGettingValueWhenSubjectNotRespondsToAspect [

	[
		aspect path: #(aspect).
		[aspect value should be: nil]
			should strictly satisfy: 
		[(subject respondsTo: #aspect) willReturn: false]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testGettingValueWhenSubjectRespondsToAspect [

	[
		aspect path: #(aspect).
		[aspect value should be: #aspectValue]
			should strictly satisfy: 
		[(subject respondsTo: #aspect) willReturn: true.
		(subject perform: #aspect) willReturn: #aspectValue]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testGettingValueWhenWhenSpecialAspectRequestHandled [

	[
		aspect path: #(aspect).
		[[aspect value should be: #result] on: PtyObjectAspectRequest do: [:r | r resume: #result]]
			should strictly satisfy: 
		[(subject respondsTo: #aspect) willReturn: false]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testSettingValueWhenLongPath [

	[:aspect1Value |
		aspect path: #(aspect1 aspect2).
		[aspect value: #newValue ]
			should strictly satisfy: 
		[(subject perform: #aspect1) willReturn: aspect1Value.
		aspect1Value perform: #aspect2: with: #newValue]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testSettingValueWhenLongPathAndSomeIsNil [

	[
		aspect path: #(aspect1 aspect2).
		[aspect value: #newValue]
			should strictly satisfy: 
		[(subject perform: #aspect1) willReturn: nil]
	] runWithMocks 

	
]

{ #category : #tests }
PtyObjectAspectTests >> testSettingValueWhenShortPath [

	[
		aspect path: #(aspect).
		[aspect value: #newValue]
			should strictly satisfy: 
		[subject perform: #aspect: with: #newValue]
	] runWithMocks 

	
]
