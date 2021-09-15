# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "ccb660186259cdeb6625a45cfb7895ab73bc89dc7cc8026de1d857066bf117e3"
    sha256 cellar: :any,                 big_sur:       "e1cbadd10cc512773582fd549a04691087626cf0f0f69b53cb91af61fa42f36c"
    sha256 cellar: :any,                 catalina:      "28b38ef3d4341198cc0c85d35a975283109b70448f1de708f4b4b3223d831f38"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "522230eac5132314c49c14f4e7748e8587718f3e6b4fb16bc163c9aa55b6b57b"
  end

  depends_on "expect"
  depends_on "tcl-tk"

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk"].opt_prefix}/lib
    ]
    stage_expect_lib
    Dir.chdir "expect-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
