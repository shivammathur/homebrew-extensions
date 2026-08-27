# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.3.tgz"
  sha256 "629c33700b591b633c13e851ffae8124758df658154e3bed828c828250508e00"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "da869e3fd61d7b47d3a2091f41d6fdfd241f8bd7cdf62803765a5c38fcdf1e2a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4d7bab2dfed0abdf73822e0cdbf0da1ae320d97aa8c7f904d279fbb997c1cbf3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fea63321e9011b085ae1b30d0b7a01bacc0a8524a914744d658f2c59d98d0820"
    sha256 cellar: :any_skip_relocation, sonoma:        "7cbb0c1649880d7d75e24a0c748547eac7f82bad91c8f37ffd5d8474eb553010"
    sha256 cellar: :any,                 arm64_linux:   "75e23af86c5834555d91424ff47b6f2a59cc0b20d0b231337b605176f3b38ab8"
    sha256 cellar: :any,                 x86_64_linux:  "63917e3f79a0e3b729975467c035dbfaeeb46890824cab32d852132887e74f81"
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
