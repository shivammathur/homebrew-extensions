# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT83 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.6.tgz"
  sha256 "be6efd52a76ed01aabdda0ce426aed0a93db4ec06908c16a5460175c35b0d08a"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "aca24b189ddec24c1bd5dff8c7fe1ca4ca09d1bce55e793e5295ba0b1f5ab91e"
    sha256 cellar: :any,                 arm64_big_sur:  "b9ba9008674c5634344e702517d027eab30a1fc6bd6f8b98a38dc1607fc2895d"
    sha256 cellar: :any,                 monterey:       "d6d980df0633afa9e43a3d970e40e208bfcca5e9ea7d49fe837d120db6149387"
    sha256 cellar: :any,                 big_sur:        "6fdd152bb984322b97cc86adfab71b16d25b32c2a1bc009802f331a56dc47c24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4132e841cee9b851e7a345b56dd36cd46f1f1d71abab4495a6f76157d511ac2a"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
    sha256 "e4eb6c074bbab168ac47b947c195ff8cef9d51a211cdd18ca9c9ef34d27a373e"
  end

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
      end

      # Avoid flat_namespace usage on macOS
      inreplace "./configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "" if OS.mac?

      system "./configure", "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    end

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
