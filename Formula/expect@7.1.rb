# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "061c152f9c870a9421ec7af13f89c1fa161f96ca08b1abc4b887cb01a53f9fba"
    sha256 cellar: :any,                 big_sur:       "0e51a6076f3425c3db5a922d5d9752877da3e5af0dabf39671aae797ee12db66"
    sha256 cellar: :any,                 catalina:      "dca059996099b8a0d6087e6c411ef326681ee5fe7f6f585f9bccf254601b1156"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "99d2cca96d0db8ba36a8c9dc0a0a5d0287982e6b8c1e5a85eb1df725d063c98f"
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
