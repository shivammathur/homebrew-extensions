# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/043fd2f267507f4b1a611c446b97d6d4324f6c23.tar.gz"
  version "5.6.40"
  sha256 "b9744ec5afe7d7decaf58e84683d2af1a8684195c9ca8050ecc1c239f4fb19de"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "9cb82cff89ebaff9b5fa90316c8729ce99f7f28fde170651ccfb17a0be36d696"
    sha256 cellar: :any,                 arm64_big_sur:  "560f6a253f642c374bf5234eb684cbead5d7556efabbefe74fbfe590219e726e"
    sha256 cellar: :any,                 monterey:       "05447084e14dcd37538f0411554747348e93861d2c90998a8ff1a39e4fc53b01"
    sha256 cellar: :any,                 big_sur:        "2e718595723756f2e1e3ab06508bf3180334d75485e08de704ab91a2b70797b3"
    sha256 cellar: :any,                 catalina:       "347c75a2440b4580760ad0ef167d8d0037db5eb78f93a6dd88c6cc12b52351b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e6c34398766342a1b04b17e89d553934e787aa39c6f99671f63e58f69dda38d8"
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
