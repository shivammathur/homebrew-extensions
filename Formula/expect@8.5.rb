# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT85 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  revision 1
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "88897183713e04965174ec57cf0bc78857a376c1c77e85cef8e49847511da6c9"
    sha256 cellar: :any,                 arm64_sequoia: "ef37dfd5bc4808983c566faa6789c155fe9170542d67934c1a1e2a0c42b9a390"
    sha256 cellar: :any,                 arm64_sonoma:  "df466ef62875646d8ab550430cb8e1b56867e245613ae4d4002aaa4659e9d2d9"
    sha256 cellar: :any,                 sonoma:        "62b1669490321bb252ef7abb236d1c437462b27cda36f44a4dccf44c56cbb539"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f2249af8d2def705aa59b50e4b87f2b06f1921be657d54881cc876afee2f160f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5affc3d8126a95b1d0d8a099610575d52d5b2bdedddd7a3d19d1a95adc917b3f"
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
