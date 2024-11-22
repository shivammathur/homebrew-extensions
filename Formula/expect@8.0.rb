# typed: true
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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "4c7c077fe31016b10cb886dc137bdc5c5e78da655aea51c9896ed5566562209b"
    sha256 cellar: :any,                 arm64_ventura:  "1c49c4dae22d6388986cd9dc4310561cf6c48b7e41718827630c92c4f0ac70cb"
    sha256 cellar: :any,                 arm64_monterey: "9efe38f62efb05a3765da4b757a6f6b3fb07e67b2e5e9f162eb28ef232637fac"
    sha256 cellar: :any,                 arm64_big_sur:  "c9eabe750a6febc8c6eadec77bd8ff882c3b32bf90712901fad4876a9cb87b28"
    sha256 cellar: :any,                 ventura:        "ad7b3175195c0ec2ae4ddae7fa431cb69134a8619eb07404d16ded064845b2bc"
    sha256 cellar: :any,                 monterey:       "6f5f162b4d53ca345adc4978adbc3b9854dfbaa74d5fc8064c546343bc01f771"
    sha256 cellar: :any,                 big_sur:        "39b5edb70a142111f65b27c8039c0ca0929e3933062fcf9535de2be620062ee3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "139731d6b2dff8ccfc4cbb3eeee65536a665ee2688948c0dae842b2dff0b2cef"
  end

  depends_on "expect"
  depends_on "tcl-tk@8"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk@8"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
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
