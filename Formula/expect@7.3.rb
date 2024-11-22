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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "b50851b3d75769c6ec0265c5f267faf059089f839e3280a7a567bba740bafa8e"
    sha256 cellar: :any,                 arm64_ventura:  "84a2e2b89ec7e373d4dd5a5bd5a8b9b5453be2ffc098ab64667593e0dba286c4"
    sha256 cellar: :any,                 arm64_monterey: "8f6381faf2185bc578d556cda8d6f845040576fc4cfeb6578471edaa21cb7d0d"
    sha256 cellar: :any,                 arm64_big_sur:  "e9a4d74bbe613c021cbd2300a67f45144c333d7ff2e51ee7f1d42d643caa21e6"
    sha256 cellar: :any,                 ventura:        "793675851ef79de11fdc7fe8f38faaea617e934b83affa6bb12a5984b0363a00"
    sha256 cellar: :any,                 monterey:       "6a34380fe7148f5ce31fd6b6f9654d21a5d40cf996d954f1a1ba187de16a37ee"
    sha256 cellar: :any,                 big_sur:        "2706ab764efb77ca7476e7f0340618dc560df031a829c583294625019efc9140"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9f80a71f199e8cc0dac4b71bafeecef5310046fd6b05017e9d2dfd5e6383b62"
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
