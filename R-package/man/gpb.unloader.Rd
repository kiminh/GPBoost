% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpb.unloader.R
\name{gpb.unloader}
\alias{gpb.unloader}
\title{gpboost unloading error fix}
\usage{
gpb.unloader(restore = TRUE, wipe = FALSE, envir = .GlobalEnv)
}
\arguments{
\item{restore}{Whether to reload \code{gpboost} immediately after detaching from R. Defaults to \code{TRUE} which means automatically reload \code{gpboost} once unloading is performed.}

\item{wipe}{Whether to wipe all \code{gpb.Dataset} and \code{gpb.Booster} from the global environment. Defaults to \code{FALSE} which means to not remove them.}

\item{envir}{The environment to perform wiping on if \code{wipe == TRUE}. Defaults to \code{.GlobalEnv} which is the global environment.}
}
\value{
NULL invisibly.
}
\description{
Attempts to unload gpboost packages so you can remove objects cleanly without having to restart R. This is useful for instance if an object becomes stuck for no apparent reason and you do not want to restart R to fix the lost object.
}
\examples{
\dontrun{
library(gpboost)
data(agaricus.train, package = "gpboost")
train <- agaricus.train
dtrain <- gpb.Dataset(train$data, label = train$label)
data(agaricus.test, package = "gpboost")
test <- agaricus.test
dtest <- gpb.Dataset.create.valid(dtrain, test$data, label = test$label)
params <- list(objective = "regression", metric = "l2")
valids <- list(test = dtest)
model <- gpb.train(params = params,
                   data = dtrain,
                   nrounds = 10,
                   valids = valids,
                   min_data = 1,
                   learning_rate = 1,
                   early_stopping_rounds = 5)

gpb.unloader(restore = FALSE, wipe = FALSE, envir = .GlobalEnv)
rm(model, dtrain, dtest) # Not needed if wipe = TRUE
gc() # Not needed if wipe = TRUE

library(gpboost)
# Do whatever you want again with gpboost without object clashing
}

}
