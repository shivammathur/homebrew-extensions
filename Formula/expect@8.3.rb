# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT83 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "84fae8e2f813f6672cf85a1655a16b6d8986f5cfada53ce58157a040af2a3ac6"
    sha256 cellar: :any,                 arm64_big_sur:  "e060b08229c2647a3bffa2be44ec272e24df2791a566644250366dc9dc66aaf7"
    sha256 cellar: :any,                 monterey:       "a47fff7ce96971262bbdb2630ede5a836d938f0fb720bb12e9bbd51ed866634d"
    sha256 cellar: :any,                 big_sur:        "5c2a4aa66b005e1f1a46214d100e4f020b66d838f4acff30328a5bb8986b4889"
    sha256 cellar: :any,                 catalina:       "c47f5d0235e05bf99cf3442a513facec38567f0eb10d449e5946b2c605568537"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9f9d4522e04c35ba94cb2f82548ed067bd02b875454b92e49d03ca445b22dc96"
  end

  depends_on "expect"
  depends_on "tcl-tk"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk"].opt_prefix}/lib
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
    rm_rf Dir["#{lib}/libexpect*"] if OS.mac?
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
