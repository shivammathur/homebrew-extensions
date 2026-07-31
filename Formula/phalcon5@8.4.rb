# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.18.0.tgz"
  sha256 "4ec2a8509b398c75442984586b812ddcfc4e1bc6cdf546530fe4142d763e741c"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7f5f7673ca643b30c93b1b2ebb41998fe4434106250dbbd566ae29166ffb3069"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7d8397c555432c81142d9f349aa5838e43932d5ef89accc8b592fa9974ad6de6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4f921bb389bb165d5d10e1f820c4ff738255383d42ec9b41bc35df855f77a2c2"
    sha256 cellar: :any_skip_relocation, sonoma:        "e77e63c799876f776eea204180af19be6c2ce4b7a1119c65dabded651a08b7f0"
    sha256 cellar: :any,                 arm64_linux:   "78001bbb57b1baa198cd710f373fe04cca74286ebff64d0cf7524eb9bd01128b"
    sha256 cellar: :any,                 x86_64_linux:  "ad50efe560d59d28bcf2eaec09d9f7aaa654b1e55b0d06da36ad996c848d0e97"
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
