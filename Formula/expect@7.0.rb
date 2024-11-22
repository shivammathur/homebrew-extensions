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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "d43feb880f474be3d694c5e449d8460f20ecc14dbdf65f3757c7b29a6369d341"
    sha256 cellar: :any,                 arm64_ventura:  "4b18a1b9f8a3de6b18356c3171d4161085c1906748931b92375c14026af78b6b"
    sha256 cellar: :any,                 arm64_monterey: "29c936721a49ab1ac14014b8002c6ac5798d8e425011840a88602aa2ccb55d39"
    sha256 cellar: :any,                 arm64_big_sur:  "e6fbc58a5c138c9467c066ea0f0a61a37b7ee0a05d631e53a23cecaae439ddd0"
    sha256 cellar: :any,                 ventura:        "9e5b5cef7a0dd6393403c3aed9cd1f2ce63b99b120400df194d7ba80281bdb24"
    sha256 cellar: :any,                 monterey:       "99a5b5ebaf1c894559abe59beb5b3582e16380841bcb671ac0eff2e5c45f22d5"
    sha256 cellar: :any,                 big_sur:        "25a6c8b75120ec0e3c770e523eccf2cf5226ddeb1a7e053d099db944f0931d9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "085a0b91988fcd4323f5905dad2e584bf180f628f131ea271a5112ffdc611204"
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
