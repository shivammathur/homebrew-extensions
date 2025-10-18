# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT56 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "515e4a089c1c46b632de1ad24c3d207df5e3409c4fd357ea3abaaac6d35b5a34"
    sha256 cellar: :any,                 arm64_sonoma:  "900e8e441fc4ff016c2d9678747edd20a2d7fb7c4d473deb7128d82c49faa285"
    sha256 cellar: :any,                 arm64_ventura: "f0ab53b5e13df739b6bfb6d2d1a51c92931a350bd4629a98a01707382a6acbff"
    sha256 cellar: :any,                 ventura:       "38becc15c1c4f4e4fc47c817062e021a4785bb2bc3a8f854d804108fc31fd75f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c92f838f8210f2b199c0db11090f581305b60d77c09e72dcab72f3b1bd3bb4df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a054b9cb99edc9d90672f75fb67644a54533be3cedb3d43fa129cbda0b6fec54"
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
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
