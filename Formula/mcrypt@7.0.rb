# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/37dee36f6593bd700523566d56fd317e4fcd6156.tar.gz"
  version "7.0.33"
  sha256 "3d7ee005c8d21ceacf5404ecb39bb64e45277f8a4cfd3f47087bbf2ce765eb69"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f2c7157057e1d55d5aaa6e388e3d00583b6c8bf23bbee43c2a78f1dcf6c40a05"
    sha256 cellar: :any,                 arm64_big_sur:  "ed445e12be4ac8240f10dda05a7e3d9291300dfe593492bb72649104e99e9a45"
    sha256 cellar: :any,                 monterey:       "6c0dea4051d1ac42916da9f0b659f60c0f198e3c74f72a49e3052400960f832d"
    sha256 cellar: :any,                 big_sur:        "aefb5bd4eb0d6f6a5387a029f0b7c78bbc5677bbb6336666293ba19e0f12f557"
    sha256 cellar: :any,                 catalina:       "dbd2d650cee579c35a93454110db42a8867e58a85bd081142f2def70e0877b04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3fbd8f98c63e8ff413180900f03b56c9a4492b49c7ad4edbd402797db94f8b32"
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
