# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT84 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b5adc7f2296de345a8f2e59fc6b59b3509bcfb30a8e0d77127a7380134c62191"
    sha256 cellar: :any,                 arm64_ventura:  "7cb04df8eee115631d75a501ec37546b8149ed36b145abe72ca64e63fbe23dac"
    sha256 cellar: :any,                 arm64_monterey: "11ab19da9710f763fdc18f86bc515de8c1323469451cdd38a2fcd670e82769c8"
    sha256 cellar: :any,                 ventura:        "cfbbc545fbb01bba6adee06d69255a3d079726f0ddf57649b849eb829e6108dd"
    sha256 cellar: :any,                 monterey:       "32f846fd914e9c76f4a9625e9721e5a26cc5b1bdcae87926bf5bdc0e8da29eb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efb3ea5fd0fa14627620ce3ed5868266c7c612eead2d3bf03502185b9fd39534"
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
    inreplace "mcrypt.c", "ext/standard/php_rand.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
