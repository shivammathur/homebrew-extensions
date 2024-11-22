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
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "ff2302e3083acfcc2e0b9832e7f2d0702815dc49e180a5ff728f974896a062df"
    sha256 cellar: :any,                 arm64_ventura:  "fb58ca8946e3cdaf376633e7c3439123f03fb8df67b78064d0a95913735e2dcd"
    sha256 cellar: :any,                 arm64_monterey: "6ce0530e4537351b771da1f6b0c5ba7222f0bb0a5864b2b65c25d6aa8bdc8e98"
    sha256 cellar: :any,                 arm64_big_sur:  "b4aa1a8dcfc28a39e381eb1b162a7b1a7efe0dfa1131dc884f598edbfddb6c07"
    sha256 cellar: :any,                 ventura:        "727c9138bfec32e3107b2a27b2da9d420297e7a22fea70973f2d1b6ca600c38b"
    sha256 cellar: :any,                 monterey:       "c493f83677b426374f50c32595e5071b81f5bf29e22a343d5f281f8d16d3d9fe"
    sha256 cellar: :any,                 big_sur:        "4f7bed008d6bb5e3b62efe5b1a2c457a78b7f396d2a0ec43853b9819438c8708"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cdc7fc5588c01daf661ef10ed471e09b0d049b212c0585563b6058645b01f51e"
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
