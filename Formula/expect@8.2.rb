# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT82 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia:  "7680af032087165ec9acd3cb27b7e10c71f6992e160cc20e7b6a045d2796031a"
    sha256 cellar: :any,                 arm64_ventura:  "fb4acb3d0827a9bcb5c9c033591d20530075300003051c509b401928dac3169e"
    sha256 cellar: :any,                 arm64_monterey: "c021ffae06be734d56577cc5e35c75836e711b781d891654cb9afa3abe434cc8"
    sha256 cellar: :any,                 arm64_big_sur:  "3fd9350c63cd6feca569d7459d691ff74e30036c69eb94c93181fd9d12a58e66"
    sha256 cellar: :any,                 ventura:        "85592a5d53fb3fc1822fcb5933988f6bc7e0074de8088857719b23b1cf24b1e8"
    sha256 cellar: :any,                 monterey:       "edea134e8c01a93f0bd18cd916eb90116df6a29b283e24166741f2a7efa548d1"
    sha256 cellar: :any,                 big_sur:        "f838245af03644510849c3851e3fe7967a35bad60a36c157ed144e89a76b659a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "137ab8ac19a8db36d65a84ce441b6991b08b5545f054aff9ad9e5f6d2a32c505"
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
