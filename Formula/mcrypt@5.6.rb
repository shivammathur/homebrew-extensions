# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2f0da72721b16b74c602d3c80f527e07d1cdd49a.tar.gz"
  version "5.6.40"
  sha256 "595bb86a07ce587ae98a04cf1d3cb23f2280a90867a11cc312d67a4b1e87911a"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any, arm64_golden_gate: "2d0e8ad67f118f5b8c41045010d437855a2b8ecfe5753009ab32319d8b43b573"
    sha256 cellar: :any, arm64_tahoe:       "6b952270475af3558461b9a24b16ab4288a3d333ae0a44e028f107d51c6f9f1f"
    sha256 cellar: :any, arm64_sequoia:     "109621f282e47950ad8ef3ffe16403b94b4e29cb4d68d04b856aaa089f124865"
    sha256 cellar: :any, arm64_linux:       "caa3172c477f0036fde3fa66f8cbcecbf3cd1e42db171dc7b88160f7156feccb"
    sha256 cellar: :any, x86_64_linux:      "813c5e1734a05f6836b7f88a51e4439a779c831a2a49aa0bf39ca1d44556a627"
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
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}",
fn
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
