# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.2.tgz"
  sha256 "d16b250a1efe85b7083125731a5f664ac6bc16114e09da5f63fac085769cc48d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4b0b0df36b4a31e6c48a03c5417b795924687c068b08d54998810f696fd56279"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3867ce5a075a149552058e37410e815482d03bf64a334a27c936d3310e9c4e77"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2ba2d41010e6eb0e45330dca600407202c3fa65d183e056669f5ae8f088ae90d"
    sha256 cellar: :any_skip_relocation, sonoma:        "fd93a98f6499719d584bf4b2ad19d54f556f0812171481601d7c8e3b4967f7e3"
    sha256 cellar: :any,                 arm64_linux:   "1db116286b6b9d9ed06dd65d09964718f4eea189d51e384fae97a036f255c018"
    sha256 cellar: :any,                 x86_64_linux:  "96c865a1627544d5ffb841ad9e8e325ad02e9b2ad7b92e97c890848ef3d64568"
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
