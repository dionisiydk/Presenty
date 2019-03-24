Class {
	#name : #PtyUserRequestTest,
	#superclass : #TestCase,
	#instVars : [
		'request'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyUserRequestTest >> setUp [ 
	super setUp.
	
	request := PtyUserRequest new.
]

{ #category : #tests }
PtyUserRequestTest >> testExecution [

	[:guide |
		request viewAreaActivator: #activator.
		[request executeBy: guide]
			should strictly satisfy: 
		[(guide runInUI: Any) will: [:block | block value].
		guide showViewAreaBy: #activator]	
	] runWithMocks 
]

{ #category : #tests }
PtyUserRequestTest >> testSignalling [

	[PtyUserRequest with: #viewAreaActivator] should raise: PtyUserRequest.

	[PtyUserRequest with: #viewAreaActivator] on: PtyUserRequest do: [:err | 
		err viewAreaActivator should be: #viewAreaActivator].
	
	
]
