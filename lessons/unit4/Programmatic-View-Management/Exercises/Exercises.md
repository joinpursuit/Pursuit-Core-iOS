# Exercise Solutions to Programmatic Autolayout
---

### 1. `NSLayoutConstraint` Practice Set

```swift
	func practice_1() {
		self.redView.isHidden = false
		self.redView.translatesAutoresizingMaskIntoConstraints = false

		let redWidthConstraint = NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0)

		let redHeightConstraint = NSLayoutConstraint(item: redView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0)

		let redLeadingConstraint = NSLayoutConstraint(item: redView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)

		let redBottomConstraint = NSLayoutConstraint(item: redView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)

		self.view.addConstraints([redLeadingConstraint, redBottomConstraint])
		self.redView.addConstraints([redWidthConstraint, redHeightConstraint])
	}

	func practice_2() {
		self.pinkView.isHidden = false
		self.pinkView.translatesAutoresizingMaskIntoConstraints = false

		let pinkWidthConstraint = NSLayoutConstraint(item: pinkView, attribute: .width, relatedBy: .equal, toItem: blueView, attribute: .width, multiplier: 0.5, constant: 0.0)

		let pinkHeightConstraint = NSLayoutConstraint(item: pinkView, attribute: .height, relatedBy: .equal, toItem: blueView, attribute: .height, multiplier: 0.5, constant: 0.0)

		let pinkTopConstraint = NSLayoutConstraint(item: pinkView, attribute: .top, relatedBy: .equal, toItem: blueView, attribute: .bottom, multiplier: 1.0, constant: 0.0)

		let pinkCenterXConstraint = NSLayoutConstraint(item: pinkView, attribute: .centerX, relatedBy: .equal, toItem: blueView, attribute: .centerX, multiplier: 1.0, constant: 0.0)

		// note: here we add all of these constraints to the super view
		self.view.addConstraints([pinkWidthConstraint, pinkHeightConstraint,pinkTopConstraint, pinkCenterXConstraint])
	}

	func practice_3() {
		self.greenView.isHidden = false
		self.greenView.translatesAutoresizingMaskIntoConstraints = false

		let greenWidthConstraint = NSLayoutConstraint(item: greenView, attribute: .width, relatedBy: .equal, toItem: redView, attribute: .width, multiplier: 1.0, constant: 0.0)

		let greenHeightConstraint = NSLayoutConstraint(item: greenView, attribute: .height, relatedBy: .equal, toItem: pinkView, attribute: .height, multiplier: 1.0, constant: 0.0)

		let greenLeadingConstraint = NSLayoutConstraint(item: greenView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 16.0)

		let greenTopConstraint = NSLayoutConstraint(item: greenView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 16.0)

		self.view.addConstraints([greenWidthConstraint, greenHeightConstraint, greenTopConstraint, greenLeadingConstraint])
	}
```

### 2. Centering Something With VFL

```swift
  internal func centerViewWithVFL() {
    // visual format language
	blueView.isHidden = false

    let blueWidth = "H:[view]-(<=0.0)-[tobias(200.0)]"
    let blueHight = "V:[view]-(<=0.0)-[tobias(200.0)]"
    let views = ["tobias" : blueView,
                 "view" : self.view]

    blueView.translatesAutoresizingMaskIntoConstraints = false
    let blueWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: blueWidth, options: .alignAllCenterY, metrics: nil, views: views)

    let blueHeightConstraints = NSLayoutConstraint.constraints(withVisualFormat: blueHight, options: .alignAllCenterX, metrics: nil, views: views)

    NSLayoutConstraint.activate( blueHeightConstraints)
    NSLayoutConstraint.activate(blueWidthConstraints)
  }
```

### 3. Pinning To Corners With VFL

```swift
	func pinToCorners() {
		self.redView.isHidden = false
		self.greenView.isHidden = false
		self.pinkView.isHidden = false
		self.blueView.isHidden = false

		self.redView.translatesAutoresizingMaskIntoConstraints = false
		self.greenView.translatesAutoresizingMaskIntoConstraints = false
		self.pinkView.translatesAutoresizingMaskIntoConstraints = false
		self.blueView.translatesAutoresizingMaskIntoConstraints = false

		let viewsDictionary = [
			"redView":redView,
			"blueView":blueView,
			"greenView":greenView,
			"pinkView":pinkView
		]

		let metricsDictionary = [
			"standardW":100,
			"standardH":100
		]

		let topBlue = "V:|[blueView(standardH)]"
		let leftBlue = "H:|[blueView(standardW)]"

		let bottomRed = "V:[redView(standardH)]|"
		let leftRed = "H:|[redView(standardW)]"

		let rightGreen = "H:[greenView(standardW)]|"
		let topGreen = "V:|[greenView(standardH)]"

		let bottomPink = "V:[pinkView(standardH)]|"
		let rightPink = "H:[pinkView(standardW)]|"

		let blueHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: leftBlue, options: [], metrics: metricsDictionary, views: viewsDictionary)
		let blueVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: topBlue, options: [], metrics: metricsDictionary, views: viewsDictionary)

		let redHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: leftRed, options: [], metrics: metricsDictionary, views: viewsDictionary)
		let redVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: bottomRed, options: [], metrics: metricsDictionary, views: viewsDictionary)

		let greenHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: rightGreen, options: [], metrics: metricsDictionary, views: viewsDictionary)
		let greenVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: topGreen, options: [], metrics: metricsDictionary, views: viewsDictionary)

		let pinkHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: rightPink, options: [], metrics: metricsDictionary, views: viewsDictionary)
		let pinkVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: bottomPink, options: [], metrics: metricsDictionary, views: viewsDictionary)

		NSLayoutConstraint.activate(blueHorizontalConstraints)
		NSLayoutConstraint.activate(blueVerticalConstraints)
		NSLayoutConstraint.activate(redHorizontalConstraints)
		NSLayoutConstraint.activate(redVerticalConstraints)
		NSLayoutConstraint.activate(greenHorizontalConstraints)
		NSLayoutConstraint.activate(greenVerticalConstraints)
		NSLayoutConstraint.activate(pinkHorizontalConstraints)
		NSLayoutConstraint.activate(pinkVerticalConstraints)
	}
```

### 4. Three Horizontal Views

```swift
  internal func threeHorizontalViews() {
	blueView.isHidden = false
	pinkView.isHidden = false
	greenView.isHidden = false

    let dict: [String : UIView] = [
      "blue" : blueView,
      "pink" : pinkView,
      "green" : greenView
    ]

    let metric: [String : Any] = [
      "viewWidth" : 50.0,
      "viewHeight" : 100.0
    ]

    let blueHConstraints = "V:|-(8.0)-[blue(viewWidth)]"
    let pinkHConstraints = "V:|-(8.0)-[pink(viewWidth)]"
    let greenHConstraints = "V:|-(8.0)-[green(viewWidth)]"

    let verticalConstraints = "H:|-(8.0)-[blue(viewHeight)]-[pink(viewHeight)]-[green(viewHeight)]"

    blueView.translatesAutoresizingMaskIntoConstraints = false
    greenView.translatesAutoresizingMaskIntoConstraints = false
    pinkView.translatesAutoresizingMaskIntoConstraints = false

    let verts = NSLayoutConstraint.constraints(withVisualFormat: verticalConstraints, options: [], metrics: metric, views: dict)
    let blueHorz = NSLayoutConstraint.constraints(withVisualFormat: blueHConstraints, options: [], metrics: metric, views: dict)
    let pinkHorz = NSLayoutConstraint.constraints(withVisualFormat: pinkHConstraints, options: [], metrics: metric, views: dict)
    let greenHorz = NSLayoutConstraint.constraints(withVisualFormat: greenHConstraints, options: [], metrics: metric, views: dict)
    NSLayoutConstraint.activate(verts)
    NSLayoutConstraint.activate(blueHorz)
    NSLayoutConstraint.activate(pinkHorz)
    NSLayoutConstraint.activate(greenHorz)
}
```

### 5. Shifting GreenView Over

```swift
  	internal func twoVerticalsAndATrailingGreenWith200Height() {
		blueView.isHidden = false
		pinkView.isHidden = false
		greenView.isHidden = false
	    blueView.translatesAutoresizingMaskIntoConstraints = false
	    pinkView.translatesAutoresizingMaskIntoConstraints = false
	    greenView.translatesAutoresizingMaskIntoConstraints = false

	    // center X & Y, 100pt sides
	    blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	    blueView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	    blueView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
	    blueView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

	    // center X, 100pt sides, lined up by trailing/leading. -8pt from blue view
	    pinkView.bottomAnchor.constraint(equalTo: blueView.topAnchor, constant: -8.0).isActive = true
	    pinkView.widthAnchor.constraint(equalTo: blueView.widthAnchor).isActive = true
	    pinkView.heightAnchor.constraint(equalTo: pinkView.widthAnchor).isActive = true
	    pinkView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor).isActive = true
	    pinkView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor).isActive = true


	    // green leading == blue trailing
	    // green trailing == view trailing
	    // green top == blue top
	    // green height == 100.0
	    greenView.topAnchor.constraint(equalTo: blueView.topAnchor).isActive = true
	    greenView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
		greenView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: 8.0).isActive = true
	    greenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8.0).isActive = true

	    let label = UILabel()
	    label.text = "Hello, World"
	    label.translatesAutoresizingMaskIntoConstraints = false

	    greenView.addSubview(label)
	    label.leadingAnchor.constraint(equalTo: greenView.leadingAnchor).isActive = true
	    label.centerYAnchor.constraint(equalTo: greenView.centerYAnchor).isActive = true
  	}
```
