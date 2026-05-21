# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/29e84585e66b01b94f8dc0059dedcc8c55820018.tar.gz"
  version "7.0.33"
  sha256 "87e056213c805ea6c4e6f5527dfa526bbdc74e93d4e64d2d972eb3dd33aa6ba0"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_tahoe:   "9ccfa9b86ff6c9a734447bd4f959b911db30adb9a9cde7f4ec4625ef5c9374e8"
    sha256 cellar: :any,                 arm64_sequoia: "0ef1b21cfa6f67c9b128658701237eb2cd63b671ab529528058fc546085cc0fd"
    sha256 cellar: :any,                 arm64_sonoma:  "8c0381b8e7cb43a410a5fb85e4754356a566f91a3cc6b82d444f761892e2f5fa"
    sha256 cellar: :any,                 sonoma:        "1d08cdd8b0666595fb7ccb834dbaf5e9270288222dc6def91b28e24904f079ee"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7a645a27295ff7103bc6574377e72cfb4ece83d8e576a60268842d122bacaed4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40038b285176603a08badd072677f8316e5b0309ebac03c21390d31c408e39fa"
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
    ENV.append "CFLAGS", "-Wno-implicit-int"

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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
