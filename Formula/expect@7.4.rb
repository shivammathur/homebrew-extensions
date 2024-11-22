# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "dac212a1bd44f6bdd59c4f98805db4427ce4a8de8413e9eeaf0539d184b08c0d"
    sha256 cellar: :any,                 arm64_ventura:  "b4a8933ad37ecc581a62b5564fc6670428d445958d9ae55897efcce4535791e5"
    sha256 cellar: :any,                 arm64_monterey: "89e822a42a4df36e2a42298736207347815bfc7332591f27543c4360f02c59ae"
    sha256 cellar: :any,                 arm64_big_sur:  "6c9f8025ed5f2ba176698221e22a92b8262e81dbe3409c1dd37190847a279ea4"
    sha256 cellar: :any,                 ventura:        "f848e585e474e6c451f99db1c1b17747a75692e5fb379193fb66389732adbd3a"
    sha256 cellar: :any,                 monterey:       "5100bc13906c6a8a9827fc5dfdc8479fee7367811bab79ed8d2a1973aca82458"
    sha256 cellar: :any,                 big_sur:        "70ad12cc02d6e78cf67715a88d8e9a4be7196d1f417f0d045d7c8bc41f733804"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64fd35a6da21e18aaffcff3454d5e944a9b27d437427d94a0bdb1d19e7fa7263"
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
    inreplace "expect.c", "ulong", "zend_ulong"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
