# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.1.tgz"
  sha256 "3a3ecb0b46bc477ed09f8156545fe87858f0e31ea55ca6110cda4594c234fb3a"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "12753450c0ffd03cf54cdc8e7b6cbdc54bbcec2b6826b891c29815c8229d7e0d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9b4000b42c665b608d96dbb2ad0caf78704486746c23bcad9bfc1db26eeaf7b9"
    sha256 cellar: :any_skip_relocation, ventura:        "1556715210be3334f88ea45d38dc53e2aa18203a0565d276ffebf99024ab349c"
    sha256 cellar: :any_skip_relocation, monterey:       "5bbb155eb6fa6f34fda77dbf8dee8b19a89d1a3298187dd55b9ec7f9a72644d0"
    sha256 cellar: :any_skip_relocation, big_sur:        "c4e13dbbd0513a586d551ce7e7bba8d2fc6a8619bd4c3c41b3ac44cae857247b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a7e399dadd58e563366ddaea894d3527ff48c167f4e55e46ddc86f3cb8ba3fb2"
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
