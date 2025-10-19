# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.3.tgz"
  sha256 "2b1983f09b56fc2779509a8ac1df776c368782538a7ef6601c0d4aef9892fe83"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6832d7fc20786e4876dda9b16737239cee5e20cdcf0fb48bcf6e30cac02cae46"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "24c11b83f408aaafc8648e02594d301265ea5af9f76370f99e75eb4c8a761ece"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "17a31e2601c7e9c59fb8eb727eb87f5d5fdfc7bc6a820c28523d3572b0078611"
    sha256 cellar: :any_skip_relocation, sonoma:        "7c7ed100c9430a8eaa8d0c3a71173a3fb9bff9aef441c005a717366c00611102"
    sha256 cellar: :any_skip_relocation, ventura:       "af29b3e8889d653c64f04d5b35b79a061d3614ac5c61381ce160efd86165cec1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "64ba7089104358b2c751dd1bd190c102f6eea6d69ace29a2165943f55647258a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "319f5aec12320c3d7311fb56de8531398fd4d8c589d1d6cc563b3321cb5819fa"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
