# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT72 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "cdfd9364f0481f3924951482a670af49f7a0e3c42dc5d3ca084874c5a7196160"
    sha256 cellar: :any,                 big_sur:       "2c3c2215b6a5df73c695496246e794c4e73a137681c43ed784207b04ec5a11de"
    sha256 cellar: :any,                 catalina:      "5d138373211d01b12732a62519fbcb7d8908e7dcceef2fb48a8b190a64705914"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45d69f31385713effceb503e5d7ab098f8d7a472b47c4e5876fd43ed5f6081f8"
  end

  depends_on "expect"
  depends_on "tcl-tk"

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk"].opt_prefix}/lib
    ]
    add_expect_lib
    Dir.chdir "expect-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
