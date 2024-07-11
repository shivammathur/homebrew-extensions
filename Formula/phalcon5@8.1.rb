# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.8.0.tgz"
  sha256 "d80b137763b790854c36555600a23b1aa054747efd0f29d8e1a0f0c5fa77f476"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8b300afbb88617e86c6a5257976a67fbd1de64fe87cb719c22584faea887d019"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c1d216d698022485cad0f642ad232aa66c14c1c5bdf840c2539291bc2b85ac1e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ba28120545d990f742638952717cc93df25533f71045e4cb7ddcd01a70e872a"
    sha256 cellar: :any_skip_relocation, ventura:        "518e2008c4209b8194c2dc917bb1193be4d402577705a910fb1caad5efa7639c"
    sha256 cellar: :any_skip_relocation, monterey:       "a7255a13c7fc907a4b0c72e508fe5467dda1b9af4f17ff0d1dc2dbf919a1ee7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "73748a9919f8677eb22bb5fc8e0c31f09fee20e7a8169e8508530fc7c9f9141e"
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
