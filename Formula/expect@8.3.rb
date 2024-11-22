# typed: true
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
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "bdf96827200fc9756b6e45d0d416952e0236b87ed233ef1f50e2b0a07d19104a"
    sha256 cellar: :any,                 arm64_ventura:  "fc41af45b12c844c8069ec17b5e057e5e2cbc96348f92ec4248f6328bf0a0189"
    sha256 cellar: :any,                 arm64_monterey: "29743c5447915c68c2e8c8410cef6702ee9cfe92d94724b64d5eb9f0f6d468be"
    sha256 cellar: :any,                 arm64_big_sur:  "923b1043c4580113521baee4474ec4d01f78a9d4e5309f8eaa760edbea76533a"
    sha256 cellar: :any,                 ventura:        "2d9f4c0948b50aa25b9c43efdf4897b7b956500930ef55b2b62274cb43f4a504"
    sha256 cellar: :any,                 monterey:       "c4e1a2bf194382e1b2d556b15d569451dbc406380e7ddaa4c428dd7122e11708"
    sha256 cellar: :any,                 big_sur:        "edc2e595399cfa95ab0f48b5db42bdc77b7340b6cf55995a5279f759024d4de0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c560a5361b20f5ee76ff872e4f1d2b4ed3f02f43bba202183e58a8f3a450bc95"
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
