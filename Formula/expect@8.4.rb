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
    sha256 cellar: :any,                 arm64_monterey: "ced30c1390aa35ae253fd242c24673cdeb781927766ab4161bf92087ce76d575"
    sha256 cellar: :any,                 arm64_big_sur:  "16fd2101ea6eddee53f95ed85dac9b2081e7c4d5557037c00db3ddc8f88eb8c8"
    sha256 cellar: :any,                 ventura:        "9a3bef6d7425ac3c47b96307b078aa7932c0b0ce59ad55dccaeff7fb2a357cd3"
    sha256 cellar: :any,                 monterey:       "a633cd32b44f08f3d920bf1980b33c66249bbf92ba0e81022caa237fbeac2024"
    sha256 cellar: :any,                 big_sur:        "9f1573993794b72d28b134a99913a73ae182e1b4f5b239101d9a12dcc618bd39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "05ffedbba47ff83721a81ff51746c3c5a592b7e828facbc1fe75d4092ad07368"
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
