# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "6cbf4d60a3264ec3ad19a088dd59779f3b778f206f2ba0dbcc7d30ce6babd95f"
    sha256 cellar: :any,                 arm64_ventura:  "2521167c4994eb61c604d68afb2b9bc2ae763fbd95e8840986ec2c18b345d56e"
    sha256 cellar: :any,                 arm64_monterey: "89a4ece135dd182b85d8caf33d5462077dca9de56ea6cae1469bf7fcc124cd8f"
    sha256 cellar: :any,                 arm64_big_sur:  "bf3761463a99271b8f38e49e1e82598938d1d5ec52c4d9b56c863cea6eb856bb"
    sha256 cellar: :any,                 ventura:        "e0d1d2e422503acbc42589aeac7ce7e4a18dc491f298ed282ae0aec0a56fa243"
    sha256 cellar: :any,                 monterey:       "41abcd40e3cef6a9645ba9d4cf82375f68c20b4b1c93dcf7855d7d2a8962107e"
    sha256 cellar: :any,                 big_sur:        "3c59aeb6ee773e5a09a9ebaa62fbfe12db0c429d195506fe895c4ed05f2b00fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b95d7064cd6b3420666c8bec5ce161bf23beb18458b05558453ab464ae9cac41"
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
