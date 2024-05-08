// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#ifndef RCPP_BayesFactor_RCPPEXPORTS_H_GEN_
#define RCPP_BayesFactor_RCPPEXPORTS_H_GEN_

#include <RcppEigen.h>
#include <Rcpp.h>

namespace BayesFactor {

    using namespace Rcpp;

    namespace {
        void validateSignature(const char* sig) {
            Rcpp::Function require = Rcpp::Environment::base_env()["require"];
            require("BayesFactor", Rcpp::Named("quietly") = true);
            typedef int(*Ptr_validate)(const char*);
            static Ptr_validate p_validate = (Ptr_validate)
                R_GetCCallable("BayesFactor", "_BayesFactor_RcppExport_validate");
            if (!p_validate(sig)) {
                throw Rcpp::function_not_exported(
                    "C++ function with signature '" + std::string(sig) + "' not found in BayesFactor");
            }
        }
    }

    inline NumericVector genhypergeo_series_pos(NumericVector U, NumericVector L, NumericVector z, const double tol, const int maxiter, const bool check_mod, const bool check_conds, const bool polynomial) {
        typedef SEXP(*Ptr_genhypergeo_series_pos)(SEXP,SEXP,SEXP,SEXP,SEXP,SEXP,SEXP,SEXP);
        static Ptr_genhypergeo_series_pos p_genhypergeo_series_pos = NULL;
        if (p_genhypergeo_series_pos == NULL) {
            validateSignature("NumericVector(*genhypergeo_series_pos)(NumericVector,NumericVector,NumericVector,const double,const int,const bool,const bool,const bool)");
            p_genhypergeo_series_pos = (Ptr_genhypergeo_series_pos)R_GetCCallable("BayesFactor", "_BayesFactor_genhypergeo_series_pos");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_genhypergeo_series_pos(Shield<SEXP>(Rcpp::wrap(U)), Shield<SEXP>(Rcpp::wrap(L)), Shield<SEXP>(Rcpp::wrap(z)), Shield<SEXP>(Rcpp::wrap(tol)), Shield<SEXP>(Rcpp::wrap(maxiter)), Shield<SEXP>(Rcpp::wrap(check_mod)), Shield<SEXP>(Rcpp::wrap(check_conds)), Shield<SEXP>(Rcpp::wrap(polynomial)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<NumericVector >(rcpp_result_gen);
    }

}

#endif // RCPP_BayesFactor_RCPPEXPORTS_H_GEN_