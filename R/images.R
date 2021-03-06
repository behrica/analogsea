image_url <- function(image = NULL) {
  url("images", image)
}

#' @param x Object to coerce to an image.
#' @export
#' @rdname images
as.image <- function(x) UseMethod("as.image")
#' @export
as.image.list <- function(x) list_to_object(x, "image")
#' @export
as.image.image <- function(x) x
#' @export
as.image.numeric <- function(x) image(x)
#' @export
as.image.character <- function(x) image(x)

#' Get list of images and their metadata, or a single image
#'
#' @importFrom plyr rbind.fill
#' @export
#' @param id (numeric) Image id.
#' @param public Include public images? If \code{FALSE}, returns only the 
#'   images that you've created (with snapshots).
#' @inheritParams droplets
#' @examples \dontrun{
#' images()
#' # Only images that you've created
#' images(public = FALSE)
#' }
images <- function(public = TRUE, page = 1, per_page = 25, ...) {
  res <- do_GET(image_url(), query = list(page = page, per_page = per_page), ...)
  images <- as.image(res)
  if (public) return(images)
  
  Filter(function(x) !x$public, images)
}

#' @export
#' @rdname images
image <- function(id, ...) {
  res <- do_GET(image_url(id), ...)
  as.image(res)
}

#' @export
print.image <- function(x, ...) {
  cat("<image> ", x$name, " (", x$id, ")", "\n", sep = "")
  cat("  Slug:    ", x$slug, " [", if (x$public) "public" else "private", 
    "]\n", sep = "")
  cat("  Distro:  ", x$distribution, "\n", sep = "")
  cat("  Regions: ", paste0(unlist(x$regions), collapse = ", "), "\n", sep = "")
}

#' @export
as.url.image <- function(x, ...) {
  image_url(x$id)
}

#' Rename/delete an image
#'
#' There is no way to restore a deleted image so be careful and ensure your data is properly
#' backed up before deleting it.
#'
#' @export
#' @param image An image to modify.
#' @param name (characer) New name for image.
#' @param ... Options passed on to httr::GET. Must be named, see examples.
#' @examples \dontrun{
#' image_delete(5620385)
#' 
#' # Delete all of your snapshots
#' lapply(images(public = FALSE), image_delete)
#' }
image_delete <- function(image, ...) {
  image <- as.image(image)
  do_DELETE(image, ...)
}


#' @export
#' @rdname image_delete
image_rename <- function(image, name, ...) {
  image <- as.image(image)
  as.image(do_PUT(image, query = list(name = name), ...))
}

#' Retrieve an action associated with a particular image id.
#'
#' @export
#' @param image An image to modify.
#' @param action_id An action id associated with an image.
#' @param ... Options passed on to httr::GET. Must be named, see examples.
#' @examples \dontrun{
#' image_actions(5710271, 31221438)
#' }
image_actions <- function(image, action_id, ...) {
  image <- as.image(image)
  res <- do_GET(sprintf('images/%s/actions/%s', image$id, action_id), ...)
  as.action(res)
}

#' Transfer an image to a specified region.
#'
#' @export
#' @param image An image to modify.
#' @param region (numeric) Required. The region slug that represents the region target.
#' @param ... Options passed on to httr::GET. Must be named, see examples.
#' @examples \dontrun{
#' image_transfer(image_id=5710271, region='nyc2')
#' image_transfer(image_id=4546004, region='nyc1')
#' }
image_transfer <- function(image, region, ...) {
  image <- as.image(image)
  
  res <- do_POST(sprintf('images/%s/actions', image$id), 
    body = list(type='transfer', region=region), ...)
  as.action(res)
}
