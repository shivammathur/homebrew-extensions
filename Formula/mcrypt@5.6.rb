# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e4e699e81f4c427582691bd0dae25f3539c3e65e.tar.gz"
  version "5.6.40"
  sha256 "95e65b163387e14ab72071e5f4676b8178298e69c4fac7eb37970dfa78daeb20"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "8f3d1831a484df776a055789c0458583b758fb026f6f3816196ae7f3a3f4e17e"
    sha256 cellar: :any,                 arm64_big_sur:  "64811ab3f01ad4c47597f52e91c2010935f607e9c076cb15e89f41bfba36692d"
    sha256 cellar: :any,                 monterey:       "f93db1b3804703b6227ea506adb7d7b119de06efc1cef05bd54d2a6163f9b73c"
    sha256 cellar: :any,                 big_sur:        "41c6a62f536827909cdfc920001bbbabad6ee8a686b9803f64a6ac0e057dabac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd5fd9862ac6e75b34a5340e3bd3463051096ba52c1aa9155b6f8d8f42fbdc8e"
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

    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
