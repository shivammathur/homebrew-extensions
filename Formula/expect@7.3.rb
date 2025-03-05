# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT73 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "da42625694cb132979dea0d08a5a8ffdcc5aa7d9d348b382ea468ea33f6e5988"
    sha256 cellar: :any,                 arm64_sonoma:  "9cbe9cfec5cf5a4bba07f0a87922f0247f1ff4980308a191717b4ed56022e381"
    sha256 cellar: :any,                 arm64_ventura: "0c956862f7384de18f4bd62dab3f97c0e2c325c20b528113ed4c2af5f04c9b9d"
    sha256 cellar: :any,                 ventura:       "4c79dda2969a3e45a80739b4b872c24d8f7be94eb651ee512731a359d9c47c42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e40969a63a9cc71bf4e49bd32040dd4a4c98c02a982398b632acec987881c958"
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
