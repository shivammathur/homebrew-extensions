# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.0.tgz"
  sha256 "417a0b39acebad34608d33ba88aa0ddc0849d45a7e4f107c1e8399f50a338916"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "dc9ac76e5e356d09ffab65883ac382903eeddb3f94e1c7da31d9eaf044019bc2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4b0a3997ccbf9d0696f6cd14c27bd9ef5fbeaf9a6d62e51c98dc47bc90e142fc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a9f8e892f47d3651ba1a55fffa194803227f93067bb324f35f359cd2d0facf6b"
    sha256 cellar: :any_skip_relocation, ventura:        "a132f3dcce99493f214f45104060464428d82ac7cc291dbcf1db32a2a1fd3782"
    sha256 cellar: :any_skip_relocation, monterey:       "5dfce6b7e95ef102892b7d442b4feb80cd08399b5925165629c8051a35bca3d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bcc7122ca5c669abb2082b19c14bca794e54e66ac5e2901006e05b7cae7e1adb"
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
