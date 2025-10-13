# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT56 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-1.1.2.tgz"
  sha256 "d35a49672e72d0e03751385e0b8fed02aededcacc5e3ec27c98a5849720483a7"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "8bce3e41d1764b8523752824cd5329688954698797c85db26859510d6cc3d3a2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "886105588faa81f0916a6fc0b2ee8c643d6a25bbcad6b1a92b179aed966b6719"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a4e3a32a506fdc93d1735c796919294c0e68b9264fb5244ec2e3d30f81ce3dd4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1d57c943684fe05596c1012f8db090220aadc2b0c34009936ae647077417cc3e"
    sha256 cellar: :any_skip_relocation, sonoma:         "c6735ab6d11eaf5bec1240206bea675e117365e2f90efb67c9b8e236db6a176f"
    sha256 cellar: :any_skip_relocation, ventura:        "2e121dca07d79b1f0960358165ee53e0c2c9f4137211b9c99a6d436754817de5"
    sha256 cellar: :any_skip_relocation, monterey:       "63b4a5b12004f7c206154be603edf0d9e8a3ec58f38f195e79d3d2e599ecb822"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "426cb8b905bba37b6af0e8cb599e02cffc97f64bfc526bc60d8f927b6caab9ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5fc439106cb0af9f316dc0e6f4349139e724e2bc0970a4a0fbebf04c6d201635"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
