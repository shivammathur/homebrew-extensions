# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fed115d16d129fdddd8ad471a92ca7d59380f48203a4b3307f90344c5e7451b1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d2a02be790079f9b5328e1e355c25102ecdf378ea4010ed51ac937456f974799"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5d75f2dcab53db1ff43375884364dde68216d11b7f3f469081f50acde8a83b6c"
    sha256 cellar: :any_skip_relocation, sonoma:        "206ebe11ce6fdff226c2022d5a7c326fdc75c7968be03c864202edbf8545a703"
    sha256 cellar: :any,                 arm64_linux:   "1891079e445a2a6f43855914d811c982e7d0ebd9c1b647a288c777cf83316d49"
    sha256 cellar: :any,                 x86_64_linux:  "ae7da0cdeb1779e6ccf7a35e1bf1d01b9e17cee3ac4c51bb471b18dc6e7aa168"
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
