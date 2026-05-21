# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "b3b58307224560697274f839d2a22c78150645043c381b4b9a13fe118c80061e"
    sha256 cellar: :any,                 arm64_sequoia: "62d162a7d202e71d50120d869579e4288301f7181f206c76a9e86b4d1ea2f0dc"
    sha256 cellar: :any,                 arm64_sonoma:  "751a1f27abd95b9d28283f52db12b238c1111ef82878c517cac85676ab3ae05e"
    sha256 cellar: :any,                 sonoma:        "9e288c109bf61dda07ea00f13a159515e4ded727aeee8ae808b0b45fa172aa6d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1984d50857e94f74817b774a1b3554032dd32c92e6f90a3711d1017dd70f2031"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fdecc13e2a2688eaee3144815411e6265bd8c272352982b37f2dd3c66e29ff77"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4cd450adf633ff3b756586f5ce8fb31a7c7f8359.tar.gz"
  version "7.1.33"
  sha256 "632a98f29d7e023b0dc4d3ae9680877f8f7aafed162345ca3318f5e9d1f87db7"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
