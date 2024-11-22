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
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "0337343b29536bd46bb0acef60a6efa5747f81b8bb0252eb1b06d12a7c5e5047"
    sha256 cellar: :any,                 arm64_ventura:  "c17556b7e68d70d957db02eac1ccdc8f2ada96695f03df8df0ec01ac68f5377d"
    sha256 cellar: :any,                 arm64_monterey: "bf064a795652d35501f7cbba8f4ef5e4b36219a3da77aec2dc0fedf43d5dc37b"
    sha256 cellar: :any,                 arm64_big_sur:  "3b074d34f594c426ec25be63d05464e0f2a62114ab2822510260aa5731f498a8"
    sha256 cellar: :any,                 ventura:        "d424cf27e4afa24e63c4f99ed6b7941d6374dcffe1deee953373eb84f51d2308"
    sha256 cellar: :any,                 monterey:       "d47f438baa0b13bb680eb1d5e2b3750cda7432d38be30e0211e5d17a355e5216"
    sha256 cellar: :any,                 big_sur:        "917b46dac2ae1bda4ff561029446b1cd4f176b081884f931afbf4d6d010ef406"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3ed9733e73e42ae7a1259db8943b3c3d87725ebd9029b7287a55e164358aeed3"
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
