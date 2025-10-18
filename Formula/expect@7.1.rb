# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "62d45a84fb18b240bc4c3d706f82d3793e980e1a58b409246b2365f8f18f5b93"
    sha256 cellar: :any,                 arm64_sonoma:  "f59bc242814e50dcd0e9e8468959d1586bc0d39730bfc8fa13cff7ef2fa0e455"
    sha256 cellar: :any,                 arm64_ventura: "427c37398145d69d447f5e1d937ce164812f56a8d6fde631c959d9cf6720e63f"
    sha256 cellar: :any,                 ventura:       "98dbf37393340a4099b2c1736e89b8cf1c81dff76ba1ef1189b1c82a95d6f613"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "55e2668c7060af9b9f7434d861e31bc139137af217ceabbea4ec04f98e5f9ec1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c29f069547d7cea31bbaa83bf0b077de9e8f5e9046cf0d97bd444db16550fbc"
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
