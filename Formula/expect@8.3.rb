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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "c63129293ebf3298e9bf1f02216d94d87846dd8a6525874212d1cc41f1fff366"
    sha256 cellar: :any,                 arm64_big_sur:  "7c21a4ceda1c113bcc3702a7f4b7a7452191b51af18beae027905e0abebcb973"
    sha256 cellar: :any,                 ventura:        "52c6a20ee7408caca5e1c35a7499a2a9175e2a58c578876232508090adec18a2"
    sha256 cellar: :any,                 monterey:       "5fa240edeb57d04c523c48a0e4fd6fa01871ebbb7c49bfd7a66973b146068a0f"
    sha256 cellar: :any,                 big_sur:        "e37a4b4ee46e84c94a20e96ce3c83fed4c3c7370380a458ad79d28bb9a93a9a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a47902900d7c0887f7afa288d8946069ba6d85da0ccc4ed6d49f9cb36d3136f"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
