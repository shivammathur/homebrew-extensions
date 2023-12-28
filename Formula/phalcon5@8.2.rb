# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.5.0.tgz"
  sha256 "cb68e8c4d082b0e3c4d0ee3d108d68dbc93880a7a581c4c492070a345f2226c3"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6d6d948a0c7ce4f83ee7361c46e8298dc0cc81ba297cb4fc0f1afbe13dafca9f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e3558063a3b13a0ec8fa4c26b3a13675bcc5e0697f4a129ef3f874f72ab40807"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "68398433ef37686f0293b402d9d11d692620132691f01ae360e6a070514abe8c"
    sha256 cellar: :any_skip_relocation, ventura:        "3a6ffdd2c232422b853fb64c1298dcd47b66f7aff852ee13d1a482231e65e30a"
    sha256 cellar: :any_skip_relocation, monterey:       "b4e98b2be0b200e7a095ac131b9eb35538eca6f5dc15c111045e89be227f2471"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a4307fb95a96c4f0625aa492c7ec3a18b7abd0cd39a9ec0c20a3c9cced196cc7"
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
