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
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "476445a36f1de03c301d33d085ecfe8707968be4955d1d0f0caed230a4b58449"
    sha256 cellar: :any,                 arm64_ventura:  "e4c7b68a19517e7cbe7b753efcaa7224e33a5b8651a9d6a2324017c8be84463c"
    sha256 cellar: :any,                 arm64_monterey: "4721975763f7ade85e73a1142eac7c267e6200e98c91b14cf48d40f994112970"
    sha256 cellar: :any,                 ventura:        "03d6dc4a2ab53f9972f0c57781048f1b53bdc38dec437b8087ea1693a04ee823"
    sha256 cellar: :any,                 monterey:       "ee42dfa3b7bca37b142b01edb415619be80438b5a1f02bc826783948f26e0561"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9c8f1f435410fd8ac9db3f4f06dd5b364f1c2f5f4b8bd38fdfbcb475d607d804"
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
