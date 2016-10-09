//
//  ZoomingAnimationController.swift
//  Pods
//
//  Created by nakajijapan on 2015/09/13.
//
//

import UIKit

public protocol ZoomingAnimationControllerTransitioning {
    func transitionSourceImageView() -> UIImageView
    func transitionDestinationImageView(_ sourceImageView: UIImageView)
}


open class ZoomingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    var present = true
    open var sourceTransition: ZoomingAnimationControllerTransitioning?
    open var destinationTransition: ZoomingAnimationControllerTransitioning?

    public init(present: Bool) {
        super.init()
        self.present = present
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if self.present {
            self.animatePresenting(transitionContext)
        } else {
            self.animateDismiss(transitionContext)
        }
    }
    
    func animatePresenting(_ transitionContext:UIViewControllerContextTransitioning) {

        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView

        let snapshotView = fromViewController.view.resizableSnapshotView(from: fromViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        containerView.addSubview(snapshotView!)
        
        toViewController.view.alpha = 0.0
        containerView.addSubview(toViewController.view)
        
        
        let backgroundView = UIView(frame: fromViewController.view.frame)
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.0
        containerView.addSubview(backgroundView)
        
        let sourceImageView = self.sourceTransition!.transitionSourceImageView()
        containerView.addSubview(sourceImageView)


        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0.0,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: { () -> Void in
                
                self.destinationTransition!.transitionDestinationImageView(sourceImageView)
                backgroundView.alpha = 1.0

            }) { (result) -> Void in
                
                sourceImageView.alpha = 0.0
                sourceImageView.removeFromSuperview()
                
                toViewController.view.alpha = 1.0
                backgroundView.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

        }
        
    }
    
    func animateDismiss(_ transitionContext:UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        
        let sourceImageView = self.sourceTransition!.transitionSourceImageView()
        containerView.addSubview(sourceImageView)

        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0.0,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: { () -> Void in
                
                self.destinationTransition!.transitionDestinationImageView(sourceImageView)
                fromViewController.view.alpha = 0.1
                
            }) { (result) -> Void in
                
                sourceImageView.alpha = 0.0
                fromViewController.view.alpha = 0.0

                sourceImageView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
        }
    }

}
