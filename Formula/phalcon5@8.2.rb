# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.21.0.tgz"
  sha256 "e7e81858b2dc11f578a3a8c4924b37d86bec67945bcca725bc34a51ba50c43f0"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "42dc2a157f82d828c78732e34293c02a21df282265c038c1fe72dd3b2d2a3c64"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "9f6e81bca4946fa9fe3673a39cd65ae1c9cd68ae0ce7d40d91768dacae9a6409"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "989148b91f59cac6aee0f750161c49877efdd048faa51e1ee82fd63e62842605"
    sha256 cellar: :any,                 arm64_linux:       "8784187f6338873253d77a6373f2c5fa42783f282ac6748bfb0372fd2fcf73bd"
    sha256 cellar: :any,                 x86_64_linux:      "5032cac8e4eaaf26dfac9ac09566e3c3fb275a1273560ea9e770300e645283e4"
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
