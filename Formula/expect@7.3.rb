# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "cb71459bcd56e049bb6094701b9b939be3036aa556ca51a81a68f0b1521f9434"
    sha256 cellar: :any,                 big_sur:       "590165f87337ac5abf9836c6a5b5ffcfa55dd93e670a3053da74064e3aa570cf"
    sha256 cellar: :any,                 catalina:      "24925b8c46b62c6c6bcd6c647c976740624899bfec61708ca828a109a018f834"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "518e667c32f0bffa052fc5a68f5e35f542397aa73eba590b6468a8c7642898dd"
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
