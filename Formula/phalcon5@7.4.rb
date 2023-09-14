# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.1.tgz"
  sha256 "3a3ecb0b46bc477ed09f8156545fe87858f0e31ea55ca6110cda4594c234fb3a"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f3b95ac173271e21d7103ba5d988c003c3fd0feb0f8914436026bb965d1b49ce"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9077817a072d57226fc6e039590190345a56f523c6f72e14156c34ab07845740"
    sha256 cellar: :any_skip_relocation, ventura:        "0501769c17837f399e1351f76ea352794734fa6aeded56691cb983047319ccbb"
    sha256 cellar: :any_skip_relocation, monterey:       "fa8aefd579c985c2c8f2b5ae34a295281f4aaad467978e67c1dce63fceb9fedc"
    sha256 cellar: :any_skip_relocation, big_sur:        "187ee9427a739eb8befbd4d5c7ee5ed9d3eb2aba0b54011e4849cbde8675f4f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fad1ce95e5d25032a69e33c35f7200e7229e38436efa52799d9365eb088c1a72"
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
