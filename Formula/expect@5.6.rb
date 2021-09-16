# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT56 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "1a85ea368935ef0e1f0b5e2bda009dfdb9e9b3dbc1c81c7d3908fb95b6684d80"
    sha256 cellar: :any,                 big_sur:       "62d958a8ec74d7fb9d54a3896cccac2682a64bd55fe6ed1d3c9d88a130452b2e"
    sha256 cellar: :any,                 catalina:      "41c33fcb271a9da43b4c56ec4a84679ca9604c27daef5142f533932382fe1676"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d6ee92d47241b9fc6a3cdf68e37dc7caab56b9e8e735e480ac752cf209497ef"
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
