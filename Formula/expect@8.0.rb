# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "281ceff7d999b1dabd40754aa48e283f04e7d685ef7755077aae5df413021045"
    sha256 cellar: :any,                 big_sur:       "6814b5a0724ab7fcf01b9443ebe34bdb8d79f7d1aff36726c4a4da610a972422"
    sha256 cellar: :any,                 catalina:      "a0058c747cb6661fc458f37e8e0e230b791120b947b2b93a6b7aec4f131ae0d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f005073c13ab839d6a41a6c0b4a64b8607b46364d8a5f421b984c7c370e0ebcc"
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
    inreplace "expect_fopen_wrapper.c", " TSRMLS_DC", ""
    inreplace "expect.c" do |s|
      s.gsub! " TSRMLS_CC", ""
      s.gsub! "ulong", "zend_ulong"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
