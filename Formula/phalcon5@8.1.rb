# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.19.0.tgz"
  sha256 "7586904d16a799a70bbc2cf6284c6ff45bdbfe10bd016c5971a20e3d943a8d15"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "124d268fb0f76fd1c459abba0168b55546bc0233b9d2ec90b815dc9567a849ae"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a8c63d451e1e48ca9532e0747e5f5c71b83b6528087e30a8bac5e3f5f5dfcbe8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "39309dab19caa61b8546f64059643e4299b37cece00e0440022232481fdba418"
    sha256 cellar: :any_skip_relocation, sonoma:        "af53f4c33c61798b3385e915bb339651294cb8bc999e1ce636e9ac6df76402c9"
    sha256 cellar: :any,                 arm64_linux:   "61defa13b389680c746acd28edac9291659636cbca04aea91c9a1315df5b89d0"
    sha256 cellar: :any,                 x86_64_linux:  "5ddab66249ef1807f645efeb9fa9d48c6537ce104dae4ad5ff8983a73740add4"
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
