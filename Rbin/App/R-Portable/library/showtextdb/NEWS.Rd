\name{NEWS}
\title{News for Package "showtextdb"}

\section{Changes in showtextdb version 3.0}{
  \itemize{
    \item New function \code{google_fonts()} to assist installing Google Fonts
          to the local machine, suggested by
          \href{https://github.com/thomas-neitmann}{@thomas-neitmann}
          (\pkg{sysfonts} issue \href{https://github.com/yixuan/showtext/issues/12}{#12}).
    \item Fixed a font loading issue when a font directory exists but with no files inside,
          thanks to the debugging by \href{https://github.com/yihui}{@yihui} and
          \href{https://github.com/XiangyunHuang}{@XiangyunHuang}
          (\pkg{showtext} issue \href{https://github.com/yixuan/showtext/issues/30}{#30}).
    \item \pkg{showtextdb} will now test for write permission before installing and
          extracting font files.
  }
}

\section{Changes in showtextdb version 2.0}{
  \itemize{
    \item New function \code{font_install()} to install fonts to the local machine.
    \item New function \code{font_installed()} to list locally installed fonts.
    \item New functions \code{source_han_sans()} and \code{source_han_serif()}
          to assist installing the Source Han Sans/Serif fonts.
  }
}

\section{Changes in showtextdb version 1.0}{
  \itemize{
    \item The initial version that separated the font file from the
          \pkg{showtext} package.
  }
}
