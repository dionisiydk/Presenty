Class {
	#name : #PtyAddUserActionTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyAddUserActionTaskTests >> taskClass [
	^PtyAddUserActionTask
]

{ #category : #tests }
PtyAddUserActionTaskTests >> testExecution [

	[:targetTask |
		task targetTask: targetTask.
		
		[task body]
			should strictly satisfy: 
		[guide addUserAction: targetTask]
	
	] runWithMocks 
]
