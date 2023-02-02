# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/541ed65f675463aea6c6eab55de38719b2d10625.tar.gz"
  version "7.0.33"
  sha256 "44a0552346687dffdeabacd4f9e641eee84f2630e852ccfd44c49e0da2fa515e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "15093dfc96d335884243b855794ee093d3ee133bf182f4a25db34eeab3690fa9"
    sha256 cellar: :any,                 arm64_big_sur:  "0206ea6c5441df43ca41316c949e668a8d392ae046cd36f1ae65a6759a102892"
    sha256 cellar: :any,                 monterey:       "cf625ec5b6a399161cc01c91e5eb99bfcffd2b77133a8b9a4cae8f165645b0a6"
    sha256 cellar: :any,                 big_sur:        "5b43243af491f4840c1bc5934b9bdd0b04d28eff9e52f15398a9a5253af4843e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "029db7655302a5b5b5141599bb99adce43a68d3c0d6ffea0a409cfdfef814285"
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
