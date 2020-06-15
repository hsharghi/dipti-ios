//
//  CollageImage.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/14/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class CollageImage {
    
    class func collage(rect: CGRect, images: [UIImage]) -> UIImage {

        guard !images.isEmpty else { return UIImage.init() }
        let maxImagesPerRow = 2
        var maxSide : CGFloat = 0.0

        if images.count >= maxImagesPerRow {
            maxSide = max(rect.width / CGFloat(maxImagesPerRow), rect.height / CGFloat(maxImagesPerRow))
        } else {
            maxSide = max(rect.width / CGFloat(images.count), rect.height / CGFloat(images.count))
        }

        var index = 0
        var currentRow = 1
        var xtransform:CGFloat = 0.0
        var ytransform:CGFloat = 0.0
        var smallRect:CGRect = .zero

        var composite: CIImage? // used to hold the composite of the images

        for img in images {

            index += 1
            let x = index % maxImagesPerRow //row should change when modulus is 0

            //row changes when modulus of counter returns zero @ maxImagesPerRow
            if x == 0 {

                //last column of current row
                smallRect = CGRect(x: xtransform, y: ytransform, width: maxSide, height: maxSide)

                //reset for new row
                currentRow += 1
                xtransform = 0.0
                ytransform = (maxSide * CGFloat(currentRow - 1))

            } else {

                //not a new row
                smallRect = CGRect(x: xtransform, y: ytransform, width: maxSide, height: maxSide)
                xtransform += CGFloat(maxSide)
            }

            // Note, this section could be done with a single transform and perhaps increase the
            // efficiency a bit, but I wanted it to be explicit.
            //
            // It will also use the CI coordinate system which is bottom up, so you can translate
            // if the order of your collage matters.
            //
            // Also, note that this happens on the GPU, and these translation steps don't happen
            // as they are called... they happen at once when the image is rendered. CIImage can
            // be thought of as a recipe for the final image.
            //
            // Finally, you an use core image filters for this and perhaps make it more efficient.
            // This version relies on the convenience methods for applying transforms, etc, but
            // under the hood they use CIFilters
            var ci = CIImage(image: img)!

            ci = ci.transformed(by: CGAffineTransform(scaleX: maxSide / img.size.width, y: maxSide / img.size.height))
            ci = ci.transformed(by: CGAffineTransform(translationX: smallRect.origin.x, y: smallRect.origin.y))

            if composite == nil {

                composite = ci

            } else {

                composite = ci.composited(over: composite!)
            }
        }

        let cgIntermediate = CIContext(options: nil).createCGImage(composite!, from: composite!.extent)
        let finalRenderedComposite = UIImage(cgImage: cgIntermediate!)

        return finalRenderedComposite
    }

    
    
}
