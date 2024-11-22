# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT84 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "76982970e8d659c80a1b0a7a2656e2e21f00aecc0921e08abf019a8ac0009ae5"
    sha256 cellar: :any,                 arm64_sonoma:  "df29c4cae238c51f1bb663ff16cd80a5fbe5d85f67c19ef2a82d3554bb1cbcad"
    sha256 cellar: :any,                 arm64_ventura: "6bffc819a652bbd1ce5d5cfd8cf1d8f35d46ec4f3a0f48723b7e3c8877dbd479"
    sha256 cellar: :any,                 ventura:       "4a5bba858eb8d35f3820297d36a7f74195ef3d4293f8a581e2879033a4ce4ef2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1633824bb63a60d8868592335f30979c94e9265b2327bb3ae22e356844e13498"
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
    ENV.append "CFLAGS", "-I#{buildpath}/expect-#{version}/include"
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
