# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT72 < AbstractPhpExtension
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
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "4ea1dd536c2a159a0c90768f9b6979763f2db5665735dd69e13ed9dafc9c4021"
    sha256 cellar: :any,                 arm64_sonoma:  "7bbd9b05bab0f598e9395c52d0a4296899e7ede908100a5f11a0707becb2fac3"
    sha256 cellar: :any,                 arm64_ventura: "f8e1dee5e50d9902cfcb9e194ee22e4ea76996be8f6446ee06b8204ceab344d8"
    sha256 cellar: :any,                 sonoma:        "447034cc3c168f788d3aecfed5de26088b813fcf4af21fcb88062cce4e300e95"
    sha256 cellar: :any,                 ventura:       "ffbda2958b122f039a9afb99e8c84512ed7aa1972e06da2ce5eae00df4946ab8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0b5b1ab0b1c98d21435a4558b53527865a99a8be276f556144f32616f39c8bef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae46c15583690ff92def4be079ee1980b75eca3eeab854e6724ac41f0a03cc42"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
