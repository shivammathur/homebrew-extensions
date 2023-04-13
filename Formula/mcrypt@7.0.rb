# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/06ccc60e1bd15158ae2047c7e9a151516dfec7c0.tar.gz"
  version "7.0.33"
  sha256 "3115b7d37e6e48c1924c243f79a335ad9c9df770f8b862d2a9536a2cee5d65ff"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "34195a42dc27f69b0a39d4f5b3cf4b2386632ff781221721b55a6d47c71fbc68"
    sha256 cellar: :any,                 arm64_big_sur:  "b3c41a9fc27423ba8a5daa2680298977293b7777b73c72b5bdc30b655d6ee8b2"
    sha256 cellar: :any,                 monterey:       "a74f31723704a3301e3cb553c60df30fddd0c2538766cc7171db9bac04a5cd67"
    sha256 cellar: :any,                 big_sur:        "678969ec99a0543df963026906dfb5c3956a7df00663e815fffdecdc0fb08a1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d62776da020a7083a22d01eac9b9b35d7824847356686031b1a39dd6525c86a0"
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
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
