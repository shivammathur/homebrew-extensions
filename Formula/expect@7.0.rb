# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "0f124f0131c71daf5e80c932d2c95df043645c1fdee79e2fb780dcf4ac24a51c"
    sha256 cellar: :any,                 arm64_sonoma:  "1204899ff9166cf444be28f16ea45d9feb2e4237a21ce720c999fe813204243a"
    sha256 cellar: :any,                 arm64_ventura: "3b4b82590c8362a655f30fbf5bfb86e2d2ed9b3dc6bf166699bb6a3dd11beb23"
    sha256 cellar: :any,                 ventura:       "4aa251b3b4dfbb893d8aad1bb32e53b8440b816e47b7c879e5e0f522f6c7dd3d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "72189e07424a4728f08f701b907482f5bbe663759a8ae4fc982cfcf79e8086c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0092f25c6f26d51d0541ce4192201767694dbcf75e0a55eab984712534de0c64"
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
