Class {
	#name : #PtyPermanentTaskReturnStrategyTest,
	#superclass : #PtyTaskReturnStrategyTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyPermanentTaskReturnStrategyTest >> createStrategy [
	^PtyPermanentTaskReturnStrategy new
]

{ #category : #tests }
PtyPermanentTaskReturnStrategyTest >> testShouldDoNothing [

	strategy prepareReturnFrom: task.
	
	task should not receive anyMessage
]
