Class {
	#name : #PtyViewAreaPresenterTests,
	#superclass : #PtyPresenterTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyViewAreaPresenterTests >> createPresenter [ 
	^PtyViewAreaPresenter new
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testActivation [

	[:areaActivator |
		[presenter activateBy: areaActivator]
			should strictly satisfy: 
		[areaActivator hasPreparedViewport willReturn: false.
		areaActivator prepareViewportBy: guide.
		areaActivator activateViewportBy: guide.
		areaActivator show: presenter by: guide	]
	
	] runWithMocks 

	
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testActivationWhenActivatorAlreadyPrepared [

	[:areaActivator |
		[presenter activateBy: areaActivator]
			should strictly satisfy: 
		[areaActivator hasPreparedViewport willReturn: true.
		areaActivator activateViewportBy: guide.
		areaActivator show: presenter by: guide	]
	
	] runWithMocks 

	
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testAddingBody [

	| actual |

	presenter addBody: #itemPresenter.
	
	actual := presenter body.
	actual should beInstanceOf: PtyViewAreaItem.
	actual presenter should be: #itemPresenter.
	actual panelName should equal: 'body'
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testAddingNewPresenterItem [

	| actual |

	presenter add: #itemPresenter on: #panelName.
	
	actual := presenter items first.
	actual should beInstanceOf: PtyViewAreaItem.
	actual presenter should be: #itemPresenter.
	actual panelName should be: #panelName
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testAddingUIAction [

	presenter addUIAction: #uiActionBlock.
		
	presenter uiActions first should be: #uiActionBlock
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testCreationCopy [

	| actual |

	presenter 
		guide: #guide;
		parent: #parent;
		name: #name;
		items: 'items';
		uiActions: 'uiActions';
		body: #bodyItem.
		
	actual := presenter createCopy.
	
	actual should beInstanceOf: PtyViewAreaPresenter.
	
	actual body should be: #bodyItem.
	actual guide should be: #guide.
	actual parent should be: #parent.
	actual name should be: #name.
	actual items should not be: 'items'.
	actual items should equal: 'items'.
	actual uiActions should not be: 'uiActions'.
	actual uiActions should equal: 'uiActions'

	
	
	
	


]

{ #category : #tests }
PtyViewAreaPresenterTests >> testHasEmptyItemsByDefault [

	presenter items should be isEmpty 
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testHasEmptyUIActionsByDefault [

	presenter uiActions should be isEmpty
]

{ #category : #tests }
PtyViewAreaPresenterTests >> testShowingViewItems [

	[:item1 :item2 :body :action1 :action2|
		presenter items: {item1. item2}.
		presenter body: body.
		presenter uiActions: {action1. action2}.
			
		[presenter showViewItems]
			should strictly satisfy: 
		[item1 showOn: presenterView by: guide.
		item2 showOn: presenterView by: guide.
		body showOn: presenterView by: guide.
		action1 value.
		action2 value]
	
	] runWithMocks 

	
]
