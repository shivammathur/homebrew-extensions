# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.3.tar.gz"
  sha256 "954e56021668121ecc50b92d2ad1ce945f22ecf81ffc5bb5835219485b12ef5f"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "687482f42004e8251643e88b64b6be9ba4a6500905086cafc04e25967aeb0746"
    sha256                               arm64_sequoia: "0dc005409573588d666ec974bce752a0a117732252f7d3c05dcb491e7b0a7fc0"
    sha256                               arm64_sonoma:  "6c7304aa2b45236f72ab3417d0ad6cc361888095c5ef34b770544e6af66f6968"
    sha256 cellar: :any_skip_relocation, sonoma:        "bf938d1b176343cd13be5ae1b786e1d029607f1a04b065fee6da0ac60d659af4"
    sha256                               arm64_linux:   "0bf238e4e0d836d073eef38b837ee0cfcca5231f095f35794e0f33217b6a90c3"
    sha256                               x86_64_linux:  "06e540aba99f3ea6f301f8d84322e8cd7dca73f3bc1fda0520d0e2bfe3fd569e"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
