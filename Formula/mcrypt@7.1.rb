# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/34a5e348a6b4ea154a4d27e51fcfa757babb4d2a.tar.gz"
  version "7.1.33"
  sha256 "e3220b4dd6d0d879bd391acb5ec23a2eaa5aa742bc1afa10515f7ba7a2725dee"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f8b1477295ddda89fa46dc286cb39080c9eeb59262236dd311cd5a0a10a76b5d"
    sha256 cellar: :any,                 arm64_big_sur:  "950cc8d1388d307118d5e8d842f4b3349374e32935d8634d5af06a88c36ba529"
    sha256 cellar: :any,                 monterey:       "cccc400ca68442d09eee1c793e21c629689769072689613f55c1a2ce0db83a59"
    sha256 cellar: :any,                 big_sur:        "bfbb3f52730eee0bfd67b16e2710419835deb3223eb20f54a3e50b04c3a42b57"
    sha256 cellar: :any,                 catalina:       "62c84e5a3b7ac1910fe7fa43307b418027ed2bac5fce0f0aa406907abbcaeb9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6564d2d577499ee8ee95022be1df9185bb0061c0ce8a024a07226576610c652e"
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
