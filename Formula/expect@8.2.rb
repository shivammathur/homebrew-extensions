# typed: false
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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "292f5f8cbd074176395a922000832c53637c64a59fa24e4a322204aca61af8f8"
    sha256 cellar: :any,                 arm64_big_sur:  "f5b42e1aea0fbb18793313da059909971c64fb3d4281912842adaa5a05739d84"
    sha256 cellar: :any,                 monterey:       "4c6775b4c7df9449baeadffb87ff144a32c717377a9c60a5888361156de34080"
    sha256 cellar: :any,                 big_sur:        "d5e5d8ee7225be08856fcac8ab499b4fce6bfdc7ad1b8ac9bbd27c7d5f2eb9a6"
    sha256 cellar: :any,                 catalina:       "e0f65290891eff2f387583806f87a864bc664f7f0f369282b602f31a2212e385"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b0dee9060876c9cda07188038138fabe7de1f223d18e5c610ceec8123c8f5923"
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
