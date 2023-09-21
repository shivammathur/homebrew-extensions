# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.1.tgz"
  sha256 "3a3ecb0b46bc477ed09f8156545fe87858f0e31ea55ca6110cda4594c234fb3a"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "92235f66db77d219cc060ffe1863090f96b9b03f9233d1fe7f5f76dee842b4c3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9320ba781bfe11daa547a779be186a9809e3d27417d73df9c9d8afb8eba51709"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dc94c5588141c676e947fba221e7616cec3d1e9d6a5a77c0db43905dd2410523"
    sha256 cellar: :any_skip_relocation, ventura:        "fb32703a256cde3ea9184b0858156de852aaf46f4f6e0379a4a0797458235f5d"
    sha256 cellar: :any_skip_relocation, monterey:       "2f9f81dc286ef9effc9f226c738b56abfbb54c8cce71505afa58dcad2ab53131"
    sha256 cellar: :any_skip_relocation, big_sur:        "35231045294555a6cfe8eb168aa9abfe334825847129984acbc03c2fea456d61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c6b9279feaf57e8b9f272f1a31154c8ce96f731db4a7e9fbc6cc7c94ae9aa5b7"
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
