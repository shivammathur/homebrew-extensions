# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "31dcff8dc45ae66261cb357c8923b494f0850c0f9ad19b84402f1242ae0916ca"
    sha256 cellar: :any,                 arm64_big_sur:  "2f7f22abd2bf6cb5dcf0730bca28f0c63b379cdc93298b61e58a62451b9427bf"
    sha256 cellar: :any,                 ventura:        "c2dd2dc1e4d42680980a2053230068baee72124a8d39f1db608cd722a7a1d0f8"
    sha256 cellar: :any,                 monterey:       "7936f60356768fdece603265fdefd32b4a92d43cf84c9e44471a830c64ae3070"
    sha256 cellar: :any,                 big_sur:        "2a31aad257afdc8d8eaa082a8834d1b0fcc1346fdd5eba5afa975002056ade91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50a2d34f78554e36b34c553e36536bf93537ee0bc707840fcdb50e8572174824"
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
