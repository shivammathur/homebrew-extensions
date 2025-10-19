# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.4.0.tgz"
  sha256 "47810a0aaa20c1a3cf0a2d7babccfa1870fa0fc78d30cefd45ed808f89d47619"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3a658a04eeee0a39dd5592114ca87936cb2084d3e27bf1aa8212d31d1049c628"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a3413b0641259c3c9143ae9873a9dfe3ebfb65cc389488768b2148db0a977b3c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dd2ba9f35c1f732a13d388e1b1e37f0cec53ab5cd3cd448d746d14b168f46bdb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c29b8b9aae57e7bac5b1713deb2b4759a912e9ec9207061c4a7a72bb3d187e59"
    sha256 cellar: :any_skip_relocation, sonoma:         "455920369fc7d90df98ffe70032dece7d9e582681daaa5ca1018b662b202c135"
    sha256 cellar: :any_skip_relocation, ventura:        "046ed5732cba376db4398f7f1cce2f12dc9feb6efc58e7244bfb8eb717d2d890"
    sha256 cellar: :any_skip_relocation, monterey:       "31de9cfcea3ddb7d94e9d0ece24329e1de5ac39d803d81f1ebe64477d3c701e0"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "4db592df613b2664dd7abc8703ba13d1bb3138c38a8feaf2e3c302c8dd711d1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "58aeb56da3f2f4bf35c493b0d90e85f79e9322f986135f8341f1db8ec1527411"
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
