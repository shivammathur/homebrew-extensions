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
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "c128364092e76f663eb3e87846eb11215efcc18858b41e0cf99e3b69c49d5d5e"
    sha256 cellar: :any,                 arm64_sonoma:   "174c76a1e56c6976c2520770f3deb1635430f65057ca59ac3686743f2ebf9740"
    sha256 cellar: :any,                 arm64_ventura:  "691ddfd380e499867cf88bb5a566fbee8cf7e11214ec51c27d89e555afd57db3"
    sha256 cellar: :any,                 arm64_monterey: "87f470d42766140aadcf5bb47dde03e63d7828a557f864a71e9255b81950a688"
    sha256 cellar: :any,                 ventura:        "351c242c9ceeb635b0c9d295d3208daf710ad069c49567f30e980bc8e0f1ee60"
    sha256 cellar: :any,                 monterey:       "053a696685458ff7744fef553807ce4b536b492171589a4c85fc7d8bf203fcb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e2f3db9c1fad49b2c27c85e4c050754e612176d0accf0cf1a3f7f11c6f2a62b5"
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
    ENV.append "CFLAGS", "-I#{buildpath}/expect-#{version}/include"
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
