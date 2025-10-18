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
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "ab2789a38ca29c024b522e58744b777265ce3eb4a95640422126e9d0bd7a97b2"
    sha256 cellar: :any,                 arm64_sonoma:  "48236f6fa03ea1048e16335debdca186caa69ae1ad401c5e7d18fa3c2382ab4d"
    sha256 cellar: :any,                 arm64_ventura: "6d3c65a3313cf6b88fbee66da48ab438843cf4435e15d61ade930b4e9d9ef0e9"
    sha256 cellar: :any,                 ventura:       "e32b3dc0d9fbcb1ed18a6e8a6dbefb03c28153100f2ac98ebdac59530a8a34d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "82c175d6db881b19b1ae5ed1ddb262a56721c3538e8031175cd7fe9ef7a9213a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "628fab7645a959ee03d61c0e81cf29939ca6f35042e065039a001124df65fb4c"
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
