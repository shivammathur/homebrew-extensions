# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.0.tgz"
  sha256 "0de5b87215177d1e3ea30dd5d71d89e128ee012b7ae1ae5bef6275a76659905b"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eeddb05d00335fd43d49aa15a7996991f1c84e6c204f5c4f7a3289373f185106"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "25beb2a3095196442bd986ce240fed1352489c41d1c1ac9a0edda10fa406df29"
    sha256 cellar: :any_skip_relocation, ventura:        "8f394a5081a73781c99eac92030842c232d3016738737702f301b28f7b1e05cc"
    sha256 cellar: :any_skip_relocation, monterey:       "2636dec6cd28af2d924a9c237c62c483415083af2fc679a8a2a9979daab3dab2"
    sha256 cellar: :any_skip_relocation, big_sur:        "e8116adec74cc28267eaf812788b2577905bcf40df1270da8c53289ea37dad2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e1d0013c9691b3e18fd9a2ce9de60eeed5b44f542ed1cf40c9e82a62855f4016"
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
