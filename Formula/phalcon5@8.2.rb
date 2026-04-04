# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.1.tgz"
  sha256 "8331f47cf760dbaf13ae2d77d63971005b03df40279dec97ede4b537d14c9591"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "324e5f6175a9b23d12f299b414d53f0d3ff6459ef5298cd43ba16ac75303547b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2f20f6ef9975015ef4ea3cbac1daa8ee00f9f23a9e000731683cea4142d31123"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9ced9f77588c8f89f50fa9552a30f6f357942e62a5f64aceb393f91bc723ce0a"
    sha256 cellar: :any_skip_relocation, sonoma:        "57ad319d96364eeb78adbf8ad2e00930dd5bfe8a7fdf0afda1e9f2d55e5f19a6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "22c03fcac776c7bb69c2135c249722ca9a1ccc40a750061dd7cc7835a1c882b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b58d7b900c261b44be6c2f5759c84111f275c17fce9d17723499d81d564286a"
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
